# frozen_string_literal: true

require_relative "uuid47/version"
require 'siphash'

module UUID47
  class Error < StandardError; end
  # Your code goes here...

  def self.encode_v4facade(id_v7, key)
    uuid_str = UUIDTools::UUID.parse(id_v7).raw
    mask = self.mask48(uuid_str, key)
    # apply mask
    new_uuid_str = self.xor_strings(mask, uuid_str[0..5]) + uuid_str[6..]
    # then set version
    self.set_version(new_uuid_str, 4)
    # then convert to UUID string
    UUIDTools::UUID.parse_raw(new_uuid_str).to_str
  end

  def self.decode_v4facade(v4facade, key)
    uuid_str = UUIDTools::UUID.parse(v4facade).raw
    mask = self.mask48(uuid_str, key)
    # (de)apply mask
    new_uuid_str = self.xor_strings(mask, uuid_str[0..5]) + uuid_str[6..]
    # then set version
    self.set_version(new_uuid_str, 7)
    # then convert to UUID string
    UUIDTools::UUID.parse_raw(new_uuid_str).to_str
  end

  private
  def self.mask48(raw, key)
    msg = ''
    msg += (raw[6].ord & 0x0f).chr
    msg += raw[7]
    msg += (raw[8].ord & 0x3F).chr
    msg += raw[9..15]
    mask_int = SipHash.digest(key, msg)
    mask = ''
    mask += (mask_int >> 40 & 0xff).chr
    mask += (mask_int >> 32 & 0xff).chr
    mask += (mask_int >> 24 & 0xff).chr
    mask += (mask_int >> 16 & 0xff).chr
    mask += (mask_int >> 8  & 0xff).chr
    mask += (mask_int >> 0  & 0xff).chr
    mask
  end

  def self.xor_strings(a, b)
    a.bytes.zip(b.bytes).map { |x, y| (x ^ y).chr }.join
  end

  def self.set_version(uuid_str, version)
    uuid_str[6] = ((uuid_str[6].ord & 0x0f) | ((version & 0x0f) << 4)).chr
  end
end

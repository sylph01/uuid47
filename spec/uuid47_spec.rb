# frozen_string_literal: true

RSpec.describe UUID47 do
  it "encodes UUIDv7 to a facaded UUIDv4" do
    key = [1234567890123456789, 9876543210987654321].pack('Q*')
    original = '01996ba2-996c-7472-aece-b7c149213a7b'
    expected = '8874573e-e474-4472-aece-b7c149213a7b'
    expect(UUID47.encode_v4facade(original, key)).to eq(expected)
  end

  it "decodes facaded UUIDv4 back to UUIDv7" do
    key = [1234567890123456789, 9876543210987654321].pack('Q*')
    original = '8874573e-e474-4472-aece-b7c149213a7b'
    expected = '01996ba2-996c-7472-aece-b7c149213a7b'
    expect(UUID47.decode_v4facade(original, key)).to eq(expected)
  end
end

module Utils
  class Util
    def self.encrypt(code)
      plu = 2
      adr1 = code[0].to_i * 10 + code[1].to_i
      adr2 = code[2].to_i * 10 + code[3].to_i + 500
      adr3 = code[0].to_i * 10 + code[3].to_i
      adr4 = code[2].to_i * 10 + code[1].to_i + 500
      adr5 = code[4].to_i * 10 + code[5].to_i

      result1 = readParmFromFlash(adr1)
      result2 = readParmFromFlash(adr2)
      result3 = readParmFromFlash(adr3)
      result4 = readParmFromFlash(adr4)
      result5 = readParmFromFlash(adr5)

      result1 = covert(result1)
      result2 = covert(result2)
      result3 = covert(result3)
      result4 = covert(result4)
      result5 = covert(result5)

      temp = result5^plu
      result = ''
      result << result1.to_s
      result << result2.to_s
      result << result3.to_s
      result << result4.to_s
      result << (temp/10).to_s
      result << (temp - temp / 10 * 10).to_s
      return result
    end

    def self.readParmFromFlash(address)
      result = nil
      f = File.open(Rails.root.join('config', 'data', 'password.bin'))
      f.seek(address)
      f.getbyte()
    end

    def self.covert(number)
      number = number - (number / 100 * 100)
      number = number - (number / 10 * 10)
    end
  end
end

module Utils
  class Util
    def self.encrypt(code)
      plu = 2
      puts adr1 = code[0].to_i * 10 + code[1].to_i
      puts adr2 = code[2].to_i * 10 + code[3].to_i + 500
      puts adr3 = code[0].to_i * 10 + code[3].to_i
      puts adr4 = code[2].to_i * 10 + code[1].to_i + 500
      puts adr5 = code[4].to_i * 10 + code[5].to_i

      puts result1 = readParmFromFlash(adr1)
      puts result2 = readParmFromFlash(adr2)
      puts result3 = readParmFromFlash(adr3)
      puts result4 = readParmFromFlash(adr4)
      puts result5 = readParmFromFlash(adr5)

      puts result1 = covert(result1)
      puts result2 = covert(result2)
      puts result3 = covert(result3)
      puts result4 = covert(result4)
      puts result5 = covert(result5)

      temp = result5^plu
      puts result = ''
      puts result << result1.to_s
      puts result << result2.to_s
      puts result << result3.to_s
      puts result << result4.to_s
      puts result << (temp/10).to_s
      puts result << (temp - temp / 10 * 10).to_s
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

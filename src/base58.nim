# base58
# Copyright Gavin Chun Jin
# Base58 check encoder and decoder

import bigints
import typetraits
import strutils

type 
  Radix = enum
    Base10 = 10, Base16 = 16 

proc reverse(s: string): string =
  result = newString(s.len)
  for i, c in s:
    result[s.high - i] = c

proc toBase58(s: string, radix: Radix = Base16): string =
  let 
    big58 = 58.initBigInt
    big0 = 0.initBigInt
    alphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"

  result = ""

  if radix == Base10:
      var x = initBigInt(s, 10)
      while x > big0: 
          var r = x.mod(big58)
          # echo r, "  ", r.type.name, parseInt(r.toString(10))
          result &= alphabet[parseInt(r.toString(10))]
          x = x.div(big58)
          
      result = reverse(result)
  else:
      # TODO for base16 hashes
      # REF https://rosettacode.org/wiki/Base58Check_encoding
      result = "TODO" 

when isMainModule:
  import unittest
  suite "test encodings":
    test "base10":
      check:
        toBase58("25420294593250030202636073700053352635053786165627414518", Base10) == "6UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM"
    test "base16":
      check:
        toBase58("0x73696d706c792061206c6f6e6720737472696e67", Base16) == "2cFupjhnEsSn59qHXstmK2ffpLv2"

use context dcic2024
provide *
provide-types *

# Standalone version: no js-file import.

# --- Reference "encryptors" (simple examples, just to make the demo run) ---

fun encryptor1(s :: String) -> String:
  string-repeat(s, 2)
end

fun encryptor2(s :: String) -> String:
  string-substring(s, 0, num-min(4, string-length(s)))
end

fun encryptor3(s :: String) -> String:
  string-to-upper(s)
end

fun encryptor4(s :: String) -> String:
  string-replace(s, " ", "-")
end

fun encryptor5(s :: String) -> String:
  string-to-lower(s)
end

fun encryptor6(s :: String) -> String:
  string-append(s, "!")
end

fun encryptor7(s :: String) -> String:
  string-from-code-points([97,98,99]) # "abc"
end

fun encryptor8(s :: String) -> String:
  string-reverse(s)
end

fun encryptor9(s :: String) -> Number:
  string-to-code-point(string-substring(s, 0, 1))
end

fun encryptor10(s :: String) -> String:
  encryptor4(encryptor6(encryptor5(s)))
end

# --- Helpers ---
fun clamp(n, lo, hi): if n < lo: lo else if n > hi: hi else: n end end end

# --- Test harnesses ---
# Each test returns a summary string like "3/3 tests passed!"

fun test-encryptor1(f :: (String -> String)) -> String:
  cases = [["hi", "hihihihihi"],
           ["abc", "abcabcabcabcabc"],
           ["", ""]]
  passed =
    fold(lam(c, acc):
           s = c[0]
           expect = string-repeat(s, 5)
           if f(s) == expect: acc + 1 else: acc end
         end, 0, cases)
  string-append(num-to-string(passed), "/",
                num-to-string(length(cases)), " tests passed!")
where:
  test-encryptor1(lam s: string-repeat(s,5) end) is "3/3 tests passed!"
end

fun test-encryptor2(f :: (String -> String)) -> String:
  cases = ["hello.", "abcd", "a"]
  passed =
    fold(lam(s, acc):
           e = string-substring(s, 0, num-min(4, string-length(s)))
           if f(s) == e: acc + 1 else: acc end
         end, 0, cases)
  string-append(num-to-string(passed), "/",
                num-to-string(length(cases)), " tests passed!")
where:
  test-encryptor2(lam s: string-substring(s, 0, num-min(4, string-length(s))) end)
    is "3/3 tests passed!"
end

fun test-encryptor9(f :: (String -> Number)) -> String:
  cases = [["A", 65], ["a", 97], ["!", 33]]
  passed =
    fold(lam(c, acc):
           s = c[0]
           e = c[1]
           if f(s) == e: acc + 1 else: acc end
         end, 0, cases)
  string-append(num-to-string(passed), "/",
                num-to-string(length(cases)), " tests passed!")
where:
  test-encryptor9(lam s: string-to-code-point(string-substring(s,0,1)) end)
    is "3/3 tests passed!"
end

fun test-encryptor10(f :: (String -> String)) -> String:
  # Loose property tests: deterministic and returns a String
  inputs = ["Hello", "Pyret", "test case"]
  passed =
    fold(lam(s, acc):
           r1 = f(s)
           r2 = f(s)
           cond1 = (r1 == r2)
           cond2 = is-string(r1)
           if cond1 and cond2: acc + 1 else: acc end
         end, 0, inputs)
  string-append(num-to-string(passed), "/",
                num-to-string(length(inputs)), " tests passed!")
where:
  test-encryptor10(lam s: encryptor4(encryptor6(encryptor5(s))) end)
    is "3/3 tests passed!"
end

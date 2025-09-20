import file("lab2-support-standalone.arr") as support

"1..."
support.encryptor1("hello.")

fun my-encryptor1(s :: String) -> String:
  string-repeat(s, 5)
end

support.test-encryptor1(my-encryptor1)

"2..."
support.encryptor2("hello.")

# fixed name to use hyphens consistently
fun my-encryptor2(s :: String) -> String:
  string-substring(s, 0, num-min(4, string-length(s)))
end

support.test-encryptor2(my-encryptor2)

"9..."
# reference output helper
support.encryptor9("A")

fun my-encryptor9(s :: String) -> Number:
  string-to-code-point(string-substring(s, 0, 1))
end

support.test-encryptor9(my-encryptor9)

"10..."
support.encryptor10("Hello")

# add minimal definitions for 4/5/6 so my-encryptor10 composes them
fun my-encryptor4(s :: String) -> String:
  string-replace(s, " ", "-")
end

fun my-encryptor5(s :: String) -> String:
  string-to-lower(s)
end

fun my-encryptor6(s :: String) -> String:
  string-append(s, "!")
end

fun my-encryptor10(s :: String) -> String:
  my-encryptor4(my-encryptor6(my-encryptor5(s)))
end

support.test-encryptor10(my-encryptor10)

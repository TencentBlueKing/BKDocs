# Common wildcard characters

| Character | Meaning | Example |
| -------------------------- | -------------------------------------- | ----------------------------------------------------------------------------------- |
| * | Matches 0 or more characters | a*b, there can be any character of any length between a and b, or there can be none, such as aabcb, axyzb, a012b, ab. |
| ? | matches any character | a?b, there must be only one character between a and b, it can be any character, such as aab, abb, acb, a0b. |
| [list] | Matches any single character in list | a[xyz]b, there must be only one character between a and b, but it can only be x or y or z, such as: axb, ayb, azb. |
| [!list] | Matches any single character in list except | a[!0-9]b, there must be only one character between a and b, but it cannot be an Arabic numeral, such as axb, aab, a-b. |
| [c1-c2] | Match any single character in c1-c2 | [0-9] [a-z], a[0-9]b, there must be only one character between 0 and 9 such as a0b, a1b ...a9b. |
| {string1,string2,...} | Match one of sring1 or string2 (or more) | a{abc,xyz,123}b, a and b can only be abc or xyz or 123. One of the strings. |
# useful_code
A Collection Of Useful Ruby And Rails methods.

These are fairly simple methods that I have had cause to use a lot in recent projects.

####Summary:
Copy these methods directly to the top of your Ruby script, or for Rails put them in application.rb.

Yes, folks, some of these use so-called "monkey patching". Ruby's class extensibility has gotten a bad rap. Yes, it can get you into trouble if you're not careful, but knee-jerk shunning it is like saying you should never drive a car because you might hit a tree. These are fairly innocuous methods which shouldn't hurt anything in normal use.

If you are inclined to be obsessive about modifying internals, you can implement them in other ways, but I'm not going to cover that here.



****
****
**Hash#nullify!** -- Convert blank (e.g. "", "    ") values in a hash to nil.
****
*Typical Use Case:*
Often, especially when you are dealing with external data, some values may be returned to you as empty strings or just spaces, but you would rather have those blank values all be nil.

*Result:*
All blank values in the hash are changed to nil.
NO RETURN VALUE. Modifies the hash in place, thus the "!".

*Use:*

```
h = {a => 1, :b => '', :c => 3, :d => " ", :e => 5}
h.nullify!
#=> {:a => 1, :b => nil, :c => 3, :d => nil, :e => 5}
```

****
****
**Time.hms(seconds, decimals = 0)** -- Convert seconds to HH:MM:SS or HH:MM:SS.ss format.
****

*Arguments:*
Seconds as integer or float, optional integer decimal places for including fractional seconds.

*Typical Use Case:*
Often in long-running scripts, you want to periodically output elapsed time or estimated time for compeletion (ETC). This will help you with that.

Some people use Time.at() but at 24 hours that rolls over to 0, making it useless for longer time periods.


*Returns:*
String representation of time in HH:MM:SS format. If a decimals argument > 0 is supplied, the output will include fractional seconds rounded to (decimals) digits.

*Use:*

```
Time.hms(9234.5452)
#=> "02:33:55"
Time.hms(9234.5462, 2)
#=> "02:33:54.55"
Time.hms(8765432)
#=> 2434:50:32
```

****
****
**Float#frac(decimals = 10)**
****
*Typical Use Case:*
You're tired of manually writing inline code to get numbers to the right of the decimal point.

*Returns:*
Fractional part of the floating point number.
Can be rounded to a specific number of decimal places with optional 'decimals' argument.
Number of digits normally limited to 8 to reduce floating-point error. Recommend 8 or fewer.

*Use:*

```
x = 1234.12345678912345678123456
#=> 1234.1234567891236
x.frac
#=> 0.12345679
x.frac(14)
#=> 0.12345678912357    (Small error.)
x.frac(6)
#=> 0.123457
x.frac(4)
#=> 0.1235
x.frac(3)
#=> 0.123
```

****
****
**String#capostrophe**
****
*Typical Use Case:*
I don't know if any use-cases could be called 'typical'. This string method takes names containing apostrophes and capitalizes them properly. Yes, it was needed in production. Don't ask why.

*Returns:*
Fixes incorrect capitalization in names with apostrophes.
For our particular production purposes, this was designed to either return the string it if was changed, or nil. If you like, that can easily be modified in the code to return the string either way.

NOTE: in order to filter out possessives, name must have 2+ letters after the apostrophe.

*Uses:*

```
"o'reilly".capostrophe
#=> "O'Reilly"
"O'malley".capostrophe
#=> "O'Malley"
Etc.

some_string = "d'angelo".capostrophe || some_other_string

# Note "non-standard" use of "=" here because it can return nil.
if some_string = "o'Doul".capostrophe
  ...
end
```

****
****
**ActiveRecord::Base#nullify!** -- ActiveRecord version of nullify! for Rails.
****
*Typical Use Case:*
You are collecting data (probably from some external source) which feeds you blanks (e.g., "" or "    ") in some fields, and you want those fields to be NULL in the database record.

*Returns:*
Similar to Hash#nullify!, but for ActiveRecord objects. Converts all blank attributes in the object to nil.

NOTE: converts the object in place. nullify! by itself does not save the record.

*Use:*

```
u = User.first
#=>  <user:0x007fc27a885c40 :id => 1234, :fname = "Bob", :mname => " ", lname => "Smith">
u.nullify!
#=>  <user:0x007fc27a885c40 :id => 1234, :fname = "Bob", :mname => nil, lname => "Smith">

```

****
****
That's all for now, folks. More to come later.

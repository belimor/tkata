
# file("apth/to/the/file")

# length(var.list_var)

# for_each = toset(var.region) ### toset - convert list into a set

### numeric functions
# max(1,2,3,5)
# min(1,2,3)
# max(var.num...)
# ceil(10.5)
# floor(10.5)

### string functions
# split(",", "word1,word2,word3")
# split(",", var.my_string)
# lower(var.my_string)
# upper(var.my_string)
# title(var.my_string)
# substring(var.my_string, 0, 3)
# join(",", var.my_list)

### collection functions
# index(var.my_list, "word1")
# element(var.my_list, 2)
# contains(var.my_list, "word1")
# keys(var.my_map)
# values(var.my_map)
# lookup(var.my_map, "key_word1")
# lookup(var.my_map, "key_word1", "default_value")

# type conversion functions

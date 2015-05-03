/// log
/*
    Use: log(string[optional], vars...[1-15])
*/

var str, i, pos;
str = "";
if (argument_count > 0)
    str = string(argument[0]);
for (i = 1; i < argument_count; i += 1) {
    pos = string_pos("%v", str);
    if (pos == 0)
        str += ", "+string(argument[i]);
    else
        str = string_replace(str, "%v", string(argument[i]));
}
show_message(str);
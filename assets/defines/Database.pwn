#define SQL_HOST "localhost"
#define SQL_USER "gs37638"
#define SQL_PASS "NqZUT7k7oR"
#define SQL_BASE "gs37638"

new MySQL:gDataBaseHandler;

stock DataBaseGetString(fields[], String:value[])
{
    new fetch[256];
    mysql_fetch_field_row(fetch, fields);
    strmid(value, fetch, 0, strlen(fetch), 255);
}

stock DataBaseGetInt(fields[], &Int:value)
{
    new fetch[256];
    mysql_fetch_field_row(fetch, fields);
    value = strval(fetch);
}

stock DataBaseGetFloat(fields[], &Float:value)
{
    new fetch[256];
    mysql_fetch_field_row(fetch, fields);
    value = floatstr(fetch);
}

stock DataBaseSetString(table[], fields[], String:value[], name[], key[])
{
    mysql_real_escape_string(value, value);

    new query[512];
    format(query, 512, "UPDATE `%s` SET `%s` = '%s' WHERE `%s` = '%s'", table, fields, value, name, key);
    mysql_query(query);
}

stock DataBaseSetFloat(table[], fields[], Float:value, name[], key[])
{
    new query[512];
    format(query, sizeof(query), "UPDATE `%s` SET `%s` = '%f' WHERE `%s` = '%s'", table, fields, value, name, key);
    mysql_query(query);
}

stock DataBaseSetInt(table[], fields[], Int:value, name[], key[])
{
    new query[512];
    format(query, sizeof(query), "UPDATE `%s` SET `%s` = '%d' WHERE `%s` = '%s'", table, fields, value, name, key);
    mysql_query(query);
}
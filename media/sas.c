int parse(const char* str, int* cursor) {
    if (parse(str, cursor) && str[(*cursor)++] == 'a') {
        return 1;
    }
    return str[(*cursor)++] == 'p';
}
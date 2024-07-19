#                   Do not

Think that files written using binary is portable

#                  ALways do

2.14.4.1 Open streams on which you use fread or fwrite in binary mode. 

#  s

- `fread(void* restrict ptr , size_t size , size_t nmemb , FILE* restrict stream); `
- `fwrite(void const*restrict ptr , size_t size , size_t nmemb , FILE* restrict stream); `
- `fseek(FILE* stream , long int offset , int whence); `
- `ftell(FILE* stream); `
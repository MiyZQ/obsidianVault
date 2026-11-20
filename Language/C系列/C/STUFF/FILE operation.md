
## 移动指针到文件末尾非空行的开头(适用小文件)

```c
int endLine(FILE* file){  
    if(fseek(file,0,SEEK_END)!=0)return 1;  
    long pos = ftell(file);  
    if(!pos){//空文件返回  
        rewind(file);  
        return 0;  
    }  
    int judge = 0;  
    while (pos-->0){  
        fseek(file,pos,SEEK_SET);  
        int c = fgetc(file);  
        if (c == '\n') {  
            if (judge) {  
                fseek(file,pos + 1,SEEK_SET);  
                return 0;  
            }  
            continue;  
        }  
        if (c!='\r'&&c!=' '&&c!='\t') judge = 1;  
    }  
    //没找到说明只有一行或全为空行  
    rewind(file);  
    return 0;  
}
```
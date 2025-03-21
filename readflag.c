#include <stdio.h>

int main(int, char**) {
    FILE* flag = fopen("/srv/flag", "r");
    if (flag == NULL) {
        printf("Flag not found.\n");
        return 1;
    }

    char flag_content[128];
    fgets(flag_content, sizeof(flag_content), flag);

    printf("%s\n", flag_content);
    fclose(flag);
    return 0;
}
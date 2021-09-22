#include <stdio.h>
#include <string.h>

#include "commands.h"

#define ASIZE(x) (sizeof(x)/sizeof(x[0]))

const char pm_usage_str[] =
    "pm [command] [pkg] [options]";

struct cmd_t {
    const char *cmd;
    int (*fn)(int, const char**);
};

static struct cmd_t commands[] = {
    { "search", cmd_search },
    { "install", cmd_install },
    { "upgrade", cmd_upgrade },
    { "info", cmd_info },
    { "home", cmd_home },
};

static struct cmd_t *get_cmd(const char *s)
{
    for (int i = 0; i < ASIZE(commands); i++) {
        struct cmd_t *p = commands + i;
        if (!strcmp(s, p->cmd))
            return p;
    }
    return NULL;
}

int main(int argc, const char **argv)
{
    printf("usage: %s\n", pm_usage_str);
    return 0;
}

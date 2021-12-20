/*
 * clang.c - compiler shim
 *
 * Uses links in /pm/var/pkgmgr/select to build and exec clang
 * invocations with the selected toolchain and sdk.
 *
 * /pm/var/pkgmgr/select/toolchain => toolchain path
 * /pm/var/pkgmgr/select/sdk => sdk path
 */

#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/errno.h>
#include <sys/stat.h>
#include <unistd.h>

/* TODO: configurable */
/* const char *pm_root = "/pm"; */
const char *select_tc_link = "/pm/var/pkgmgr/select/toolchain";
const char *select_sdk_link = "/pm/var/pkgmgr/select/sdk";

const char *tc_compiler = "/usr/bin/clang";
const char *sdk_usr_inc = "/usr/include";

const int verbose = 0;

int main(int argc, char **argv)
{
    char tc_path[PATH_MAX];
    char sdk_path[PATH_MAX];
    ssize_t tc_path_size, sdk_path_size,
        compiler_path_len, cursor,
        include_path_len;
    struct stat tc_stat, sdk_stat;
    char *err, *compiler_path,
        *include_path;

    int new_argc;
    char **new_argv;

    if (lstat(select_tc_link, &tc_stat) != 0) {
        err = strerror(errno);
        fprintf(stderr, "Error: toolchain select file: %s\n", err);
        exit(1);
    }

    if (!S_ISLNK(tc_stat.st_mode)) {
        fprintf(stderr, "Error: toolchain select file is not a link");
        exit(2);
    }

    if (lstat(select_sdk_link, &sdk_stat) != 0) {
        err = strerror(errno);
        fprintf(stderr, "Error: sdk select file: %s\n", err);
        exit(3);
    }

    if (!S_ISLNK(sdk_stat.st_mode)) {
        fprintf(stderr, "Error: sdk select file is not a link");
        exit(4);
    }

    tc_path_size = readlink(select_tc_link, tc_path, PATH_MAX);
    if (tc_path_size == -1) {
        err = strerror(errno);
        fprintf(stderr, "Error: unable to read toolchain link: %s\n", err);
        exit(5);
    }
    tc_path[tc_path_size] = 0;

    sdk_path_size = readlink(select_sdk_link, sdk_path, PATH_MAX);
    if (sdk_path_size == -1) {
        err = strerror(errno);
        fprintf(stderr, "Error: unable to read sdk link: %s\n", err);
        exit(6);
    }
    sdk_path[sdk_path_size] = 0;

    new_argc = argc;
    new_argv = malloc(sizeof(char *) * new_argc);
    if (!new_argv) {
        err = strerror(errno);
        fprintf(stderr, "Error: malloc: %s\n", err);
        exit(7);
    }
    cursor = 0;

    /* add isysroot pair */
    new_argc += 2;
    new_argv = realloc(new_argv, sizeof(char *) * new_argc);
    new_argv[cursor++] = strdup("-isysroot");
    new_argv[cursor++] = sdk_path;

    /* make sdk include path */
    include_path_len = strlen(sdk_usr_inc) + sdk_path_size;
    include_path = malloc(include_path_len);
    if (!include_path) {
        err = strerror(errno);
        fprintf(stderr, "Error: malloc: %s\n", err);
        exit(8);
    }
    strncat(include_path, sdk_path, include_path_len);
    strncat(include_path, sdk_usr_inc, include_path_len);
    if (verbose)
        fprintf(stderr, "include_path=%s\n", include_path);

    /* add isystem pair */
    new_argc += 2;
    new_argv = realloc(new_argv, sizeof(char *) * new_argc);
    new_argv[cursor++] = strdup("-isystem");
    new_argv[cursor++] = include_path;

    if (verbose) {
        for (int i = 0; i < cursor; i++)
        fprintf(stderr, "new_argv[%d] = \"%s\"\n", i, new_argv[i]);
    }

    /* copy the remaining args */
    for (int i = 1, j = cursor; i < argc; i++, j++) {
        new_argv[j] = argv[i];
        if (verbose)
            fprintf(stderr, "new_argv[%d] = \"%s\"\n", j, new_argv[j]);
    }

    /* absolute path to real compiler */
    compiler_path_len = strlen(tc_compiler) + tc_path_size;
    compiler_path = malloc(compiler_path_len);
    if (!compiler_path) {
        err = strerror(errno);
        fprintf(stderr, "Error: malloc: %s\n", err);
        exit(9);
    }
    strncat(compiler_path, tc_path, compiler_path_len);
    strncat(compiler_path, tc_compiler, compiler_path_len);
    if (verbose)
        fprintf(stderr, "compiler_path=%s\n", compiler_path);

    /* run the real compiler */
    execv(compiler_path, new_argv);
    fprintf(stderr, "Error: failed to exec %s\n", compiler_path);

    return 0;
}

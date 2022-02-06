/*
 * ld.c - linker shim
 *
 * Uses links in /pm/var/pkgmgr/select to build and exec ld
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

const char *tc_linker = "/usr/bin/ld";
const char *sdk_usr_lib = "/usr/lib";

/* TODO: environment var configurable? */
const int verbose = 1;

int main(int argc, char **argv)
{
    char tc_path[PATH_MAX];
    char sdk_path[PATH_MAX];
    ssize_t tc_path_size, sdk_path_size,
        linker_path_len, cursor;/* , */
        /* library_path_len; */
    struct stat tc_stat, sdk_stat;
    char *err, *linker_path;/* , */
        /* *library_path; */

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

    new_argc = argc + 1;
    new_argv = malloc(sizeof(char *) * new_argc);
    if (!new_argv) {
        err = strerror(errno);
        fprintf(stderr, "Error: malloc: %s\n", err);
        exit(7);
    }
    cursor = 1;

    new_argv[0] = strdup("ld");

    /* NOTE: This assumes we have the -isysroot & -isystem options set
     * from being invoked from the clang shim, but we're not handling
     * a standalone linker invocation. If standalone linker
     * invocations are failing it's likely because we kicked the can
     * down the road on this.
     */

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

    new_argv[cursor + argc + 1] = 0;

    /* absolute path to real linker */
    linker_path_len = strlen(tc_linker) + tc_path_size;
    linker_path = malloc(linker_path_len);
    if (!linker_path) {
        err = strerror(errno);
        fprintf(stderr, "Error: malloc: %s\n", err);
        exit(9);
    }
    strncat(linker_path, tc_path, linker_path_len);
    strncat(linker_path, tc_linker, linker_path_len);
    if (verbose)
        fprintf(stderr, "linker_path=%s\n", linker_path);

    /* run the real linker */
    execv(linker_path, new_argv);
    err = strerror(errno);
    fprintf(stderr, "Error: failed to exec %s: %s\n", linker_path, err);

    return 0;
}

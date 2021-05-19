/*
 * partcl_interpreter.h
 *
 *  Created on: 20. apr. 2021
 *      Author: Mikkel
 */

#ifndef SRC_PARTCL_INTERPRETER_H_
#define SRC_PARTCL_INTERPRETER_H_

//MACROS_MACROS____________________________________________________________________________________________________________________________________________________________________________________

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "partcl_driver.h"
#include "DCMotorDriver.h"
#include <stdbool.h>
#include "main.h"

#if 0
#define DBG partcl_printf(sprintf
#else
#define DBG(...)
#endif

#define MAX_VAR_LENGTH 256

#define CHUNK 128

#define tcl_each(s, len, skiperr)                                              \
  for (struct tcl_parser p = {NULL, NULL, (s), (s) + (len), 0, TERROR};        \
       !initSuspension && p.start < p.end &&                                                      \
       (((p.token = tcl_next(p.start, p.end - p.start, &p.from, &p.to,         \
                             &p.q)) != TERROR) ||                              \
        (skiperr));                                                            \
       p.start = p.to)





//STATICS___________________________________________________________________________________________________________________________________________________________________________________________________

typedef char tcl_value_t;

struct tcl;

typedef int (*tcl_cmd_fn_t)(struct tcl *, tcl_value_t *, void *);

/* Token type and control flow constants */
enum { TCMD, TWORD, TPART, TERROR };
enum { FERROR, FNORMAL, FRETURN, FBREAK, FAGAIN };


/* A helper parser struct and macro (requires C99) */
struct tcl_parser {
  const char *from;
  const char *to;
  const char *start;
  const char *end;
  int q;
  int token;
};

struct tcl_cmd {
  tcl_value_t *name;
  int arity;
  tcl_cmd_fn_t fn;
  void *arg;
  struct tcl_cmd *next;
};

struct tcl_var {
  tcl_value_t *name;
  tcl_value_t *value;
  struct tcl_var *next;
};

struct tcl_env {
  struct tcl_var *vars;
  struct tcl_env *parent;
};

struct tcl {
  struct tcl_env *env;
  struct tcl_cmd *cmds;
  tcl_value_t *result;
};





//FUNCTIONS_____________________________________________________________________________________________________________________________________________________________________________________________

int tcl_eval(struct tcl *tcl, const char *s, size_t len);
int tcl_list_length(tcl_value_t *v);
int tcl_result(struct tcl *tcl, int flow, tcl_value_t *result);
int tcl_subst(struct tcl *tcl, const char *s, size_t len);
int tcl_eval(struct tcl *tcl, const char *s, size_t len);
int tcl_length(tcl_value_t *v);
int tcl_int(tcl_value_t *v);
int tcl_next(const char *s, size_t n, const char **from, const char **to, int *q);

static int tcl_is_special(char c, int q);
static int tcl_is_end(char c);
static int tcl_is_space(char c);
static int tcl_cmd_flow(struct tcl *tcl, tcl_value_t *args, void *arg);
static int tcl_cmd_math(struct tcl *tcl, tcl_value_t *args, void *arg);
static int tcl_cmd_while(struct tcl *tcl, tcl_value_t *args, void *arg);


static struct tcl_env *tcl_env_alloc(struct tcl_env *parent);
static struct tcl_var *tcl_env_var(struct tcl_env *env, tcl_value_t *name);
static struct tcl_env *tcl_env_free(struct tcl_env *env);

const char *tcl_string(tcl_value_t *v);

tcl_value_t *tcl_list_at(tcl_value_t *v, int index);
tcl_value_t *tcl_append(tcl_value_t *v, tcl_value_t *tail);
tcl_value_t *tcl_append_string(tcl_value_t *v, const char *s, size_t len);
tcl_value_t *tcl_alloc(const char *s, size_t len);
tcl_value_t *tcl_dup(tcl_value_t *v);
tcl_value_t *tcl_list_append(tcl_value_t *v, tcl_value_t *tail);
tcl_value_t *tcl_var(struct tcl *tcl, tcl_value_t *name, tcl_value_t *v);
tcl_value_t *tcl_list_alloc();

void tcl_register(struct tcl *tcl, const char *name, tcl_cmd_fn_t fn, int arity, void *arg);
void tcl_init(struct tcl *tcl);
void tcl_destroy(struct tcl *tcl);
void tcl_free(tcl_value_t *v);
void tcl_list_free(tcl_value_t *v);

void tcl_setup();

void tcl_execute();

void tcl_suspend();

void tcl_resume();

bool tcl_isFullySuspended();

#endif /* SRC_PARTCL_INTERPRETER_H_ */

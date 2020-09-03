#ifndef __CR_FANOTIFY_H
#define __CR_FANOTIFY_H

#include <stdint.h>

int fanotify_init (unsigned int __flags, unsigned int __event_f_flags);

int fanotify_mark (int __fanotify_fd, unsigned int __flags,
			  uint64_t __mask, int __dfd, const char *__pathname);

#endif /* __CR_FANOTIFY_H */

#lang scribble/manual

@require[(for-label libuuid)
         (for-label racket/base)]

@require[scribble/eval]

@define[uuid-eval (make-base-eval)]
@interaction-eval[#:eval uuid-eval (require libuuid)]

@title{libuuid}
@author+email["Jan Dvorak" "mordae@anilinux.org"]

Interface to the @tt{libuuid} library usable to generate high-quality UUIDs.


@defmodule[libuuid]

@defproc[(uuid-generate) string?]{
  Generate new universally unique identifier using @tt{/dev/urandom},
  if available. If it is not available, use current time, local ethernet
  MAC address and random data from a pseudo-random generator.

  @examples[#:eval uuid-eval
    (uuid-generate)
    (uuid-generate)
  ]
}

@defproc[(uuid-generate/random) string?]{
  When @tt{/dev/urandom} is available, same as @racket[uuid-generate],
  but fails back to a pseudo-random generator only.

  Can be used to prevent any chance of host's MAC address leaking,
  at the cost of slightly higher chance of generating non-unique
  identifiers if the worst-case situation arises on multiple hosts.

  @examples[#:eval uuid-eval
    (uuid-generate/random)
    (uuid-generate/random)
  ]
}

@defproc[(uuid-generate/time) string?]{
  Same as @racket[uuid-generate] when the @tt{/dev/urandom} is missing.

  Could potentially produce non-uniqueue identifiers if used concurrently so
  if you do not absolutely need sequential identifiers, stick with the
  generic (and safe) @racket[uuid-generate] function above.

  @examples[#:eval uuid-eval
    (uuid-generate/time)
    (uuid-generate/time)
  ]
}


@; vim:set ft=scribble sw=2 ts=2 et:

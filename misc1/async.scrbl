#lang scribble/manual

@require[scribble/eval]

@require[(for-label racket)
         (for-label misc1/async)]

@define[async-eval (make-base-eval)]
@interaction-eval[#:eval async-eval (require misc1/async)]

@title{Asynchronous Tasks}

@defmodule[misc1/async]

This module provides a simple way to run a piece of code in a background
thread, getting it's result back via Racket's integrated event system.

@defproc[(async-task (proc (-> any))) evt?]{
  Run thunk in a @racket[thread] and obtain it's cached result
  (or exception) using an event.

  @examples[#:eval async-eval
    (define result-evt
      (async-task (λ ()
                    (sleep 1/10) 42)))

    (sync/timeout 1/20 result-evt)
    (sync/timeout 1/20 result-evt)
    (sync/timeout 1/20 result-evt)
  ]
}

@defform[(async body ...)]{
  Syntactic alternative to @racket[async-task].

  @examples[#:eval async-eval
    (sync (async (+ 1 1)))
  ]
}


@; vim:set ft=scribble sw=2 ts=2 et:

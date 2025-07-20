type 'a t = 'a Lwt.t

(* Define let_catch_result with the same signature as Lwt_result.catch
   for lwt version >= 6.0. This function can be replaced by
   Lwt_result.catch if/when we bump minimum required version of Lwt to >= 6.0.
   See https://github.com/ocsigen/lwt/pull/965
*)
let lwt_result_catch f =
  Lwt.catch (fun () -> Lwt_result.ok (f ())) Lwt_result.fail

module Deferred = struct
  type 'a t = 'a Lwt.t
  let return a = Lwt.return a
  let catch f = lwt_result_catch f
  let don't_wait_for = Lwt.async
  let sleepf secs = Lwt_unix.sleep secs
  let fail exn = Lwt.fail exn

  module Infix = struct
    let (>>=) = Lwt.(>>=)
    let (<?>) = Lwt.(<?>)
  end
end

module Condition = struct
  type 'a t = 'a Lwt_condition.t
  let create () = Lwt_condition.create ()
  let wait t = Lwt_condition.wait t
  let signal t v = Lwt_condition.signal t v
end

module Mailbox = struct
  type 'a t = ('a Lwt.t * 'a Lwt.u)
  let create () = Lwt.wait ()
  let send (_, u) v = Lwt.wakeup_later u v
  let recv (t, _) = t
end

module Fd = struct
  type t = Lwt_unix.file_descr

  let create fd = Lwt_unix.of_unix_file_descr ~set_flags:false fd
  let wait_readable t = Lwt_unix.wait_read t
  let release _ = Deferred.return ()
end

(*
 * lt_windows.ml
 * -------------
 * Copyright : (c) 2011, Jeremie Dimino <jeremie@dimino.org>
 * Licence   : BSD3
 *
 * This file is a part of Lambda-Term.
 *)

open Lwt

external get_acp : unit -> int = "lt_windows_get_acp"
external get_console_cp : unit -> int = "lt_windows_get_console_cp"
external set_console_cp : int -> unit = "lt_windows_set_console_cp"
external get_console_output_cp : unit -> int = "lt_windows_get_console_output_cp"
external set_console_output_cp : int -> unit = "lt_windows_set_console_output_cp"

type input =
  | Resize
  | Key of Lt_key.t

external read_console_input_job : Unix.file_descr -> [ `read_console_input ] Lwt_unix.job = "lt_windows_read_console_input_job"
external read_console_input_result : [ `read_console_input ] Lwt_unix.job -> input = "lt_windows_read_console_input_result"
external read_console_input_free : [ `read_console_input ] Lwt_unix.job -> unit = "lt_windows_read_console_input_free"

let controls = [|
  Char.code ' ';
  Char.code 'a';
  Char.code 'b';
  Char.code 'c';
  Char.code 'd';
  Char.code 'e';
  Char.code 'f';
  Char.code 'g';
  Char.code 'h';
  Char.code 'i';
  Char.code 'j';
  Char.code 'k';
  Char.code 'l';
  Char.code 'm';
  Char.code 'n';
  Char.code 'o';
  Char.code 'p';
  Char.code 'q';
  Char.code 'r';
  Char.code 's';
  Char.code 't';
  Char.code 'u';
  Char.code 'v';
  Char.code 'w';
  Char.code 'x';
  Char.code 'y';
  Char.code 'z';
  Char.code '[';
  Char.code '\\';
  Char.code ']';
  Char.code '^';
  Char.code '_';
|]

let read_console_input fd =
  Lwt_unix.check_descriptor fd;
  Lwt_unix.execute_job
    (read_console_input_job (Lwt_unix.unix_file_descr fd))
    read_console_input_result
    read_console_input_free

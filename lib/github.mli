(*---------------------------------------------------------------------------
   Copyright (c) 2016 Daniel C. Bünzli. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
   %%NAME%% %%VERSION%%
  ---------------------------------------------------------------------------*)

(** Interface with Github. *)

open Bos_setup

module Parse : sig
  val ssh_uri_from_http : string -> string option
  (** [ssh_uri_from_http] Guess an SSH URI from a Github HTTP url. *)
end

(** {1 Publish} *)

val publish_distrib :
  token:string ->
  ?dev_repo:string ->
  dry_run:bool ->
  msg:string ->
  archive:Fpath.t ->
  yes:bool ->
  draft:bool ->
  Pkg.t ->
  (string, R.msg) Result.result
(** Push the tag, create a Github release, upload the distribution archive and
    return the release archive download URL *)

val undraft_release :
  token:string ->
  dry_run:bool ->
  owner:string ->
  repo:string ->
  release_id:string ->
  name:string ->
  (string, R.msg) Result.result
(** [undraft_release] updates an existing release to undraft it and returns the
    release archive download URL. *)

val open_pr :
  token:string ->
  dry_run:bool ->
  title:string ->
  fork_owner:string ->
  branch:Vcs.commit_ish ->
  opam_repo:string * string ->
  draft:bool ->
  string ->
  Pkg.t ->
  ([ `Url of string | `Already_exists ], R.msg) result

val undraft_pr :
  token:string ->
  dry_run:bool ->
  opam_repo:string * string ->
  pr_id:string ->
  (string, R.msg) result
(** [undraft_pr] updates an existing pull request to undraft it and returns the
    pull request URL. *)

val pr_title :
  names:string list ->
  version:Version.t ->
  project_name:string option ->
  pkgs_to_submit:string list ->
  string

(*---------------------------------------------------------------------------
   Copyright (c) 2016 Daniel C. Bünzli

   Permission to use, copy, modify, and/or distribute this software for any
   purpose with or without fee is hereby granted, provided that the above
   copyright notice and this permission notice appear in all copies.

   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
   WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
   MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
   ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  ---------------------------------------------------------------------------*)

# My NixOS setup

This repo contains my personal NixOS configuration, managed with flakes and Home Manager. It is a read-only mirror, I self-host this project with [Forgejo](https://forgejo.org/).

> **Why NixOS?** Because I like infrastructure-as-code, and in the end, Ansible forces a declarative approach on systems that were designed to be imperative. NixOS is designed to be declarative, versioned and reproducible, from the start. And it has rollback directly in the boot menu.

It runs on three hosts, kept in sync through git:
- spellbook: main laptop / daily driver
- grimoire: old laptop, kept identical to spellbook
- tower: one server to rule them all (k3s + gaming)

This configuration can be used for reference, but it is not plug-and-play and is specifically tailored to my needs. Steal whatever you want, but watch out with the modules. Not all of them are machine independent. I *try* to avoid abstracting and adding complexity ([YAGNI](https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it)).

If you want to get started with NixOS, I recommend the following resources:
- https://nixos-and-flakes.thiscute.world/
- https://www.vimjoyer.com
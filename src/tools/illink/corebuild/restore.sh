#!/usr/bin/env bash

# restore.sh will bootstrap the cli and ultimately call "dotnet
# restore". The configuration specified here is just a workaround to
# set the correct conditional properties for the netcore/netstandard
# restore in the .csproj files. It doesn't matter whether we choose
# Debug or Release here, as the same assets will be restored in either
# case.

# Normally, "dotnet restore" will also restore referenced
# projects. However, because we are using the old .csproj format,
# restore will not correctly restore project references, and so we
# need to explicitly restore Mono.Cecil as well as Mono.Linker.

working_tree_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$working_tree_root/dotnet.sh restore ../linker/Mono.Linker.csproj /p:Configuration=netcore_Debug $@
$working_tree_root/dotnet.sh restore ../cecil/Mono.Cecil.csproj /p:Configuration=netstandard_Debug $@
$working_tree_root/dotnet.sh restore ../cecil/symbols/pdb/Mono.Cecil.Pdb.csproj /p:Configuration=netstandard_Debug $@

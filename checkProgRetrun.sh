#!/bin/env bash
# Copyright (c) 2026, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.

function captureOutput() {
	tmpout=$(mktemp)
	tmperr=$(mktemp)

	$1 >$tmpout 2>$tmperr
	exitcode=$?

	stdoutCaptured=$(cat $tmpout)
	stderrCaptured=$(cat $tmperr)

	rm $tmpout $tmperr
}

ARGS=$(getopt -o p:o:e:r: --long program:,stdout:,stderr:,return: -- "$@")
if [[ $? -ne 0 ]]; then
	exit 1
fi

program=""
returnCode=0
checkStdout=false
checkStderr=false
eval set -- "$ARGS"
while [ : ]; do
	case "$1" in
	-p | --program)
		program="$2"
		shift 2
		;;
	-o | --stdout)
		checkStdout=true
		stdout="$2"
		shift 2
		;;
	-e | --stderr)
		checkStderr=true
		stderr="$2"
		shift 2
		;;
	-r | --return)
		returnCode="$2"
		shift 2
		;;
	--)
		shift
		break
		;;
	esac
done

if [[ -z $program ]]; then
	echo "missing program"
	exit 1
fi

failed=false
captureOutput $program
if [[ $exitcode != $returnCode ]]; then
	echo "[error] return code is $exitcode, expected $returnCode"
	failed=true
fi

if [[ $checkStdout == true ]]; then
	if [[ $stdout != $stdoutCaptured ]]; then
		echo "[error] stdout is '$stdout', expected '$stdoutCaptured'"
		failed=true
	fi
fi

if [[ $checkStderr == true ]]; then
	if [[ $stderr != $stderrCaptured ]]; then
		echo "[error] stderr is '$stderr', expected '$stderrCaptured'"
		failed=true
	fi
fi

if [[ $failed == true ]]; then
	exit 1
fi

# This file is part of ncc.
#
# BSD 3-Clause License
#
# Copyright (c) 2026, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
# this
#    list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

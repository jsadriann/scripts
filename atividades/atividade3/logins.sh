echo "Linhas não sshd"
grep -v "sshd" auth.log

echo "Logins via sshd cujo usuário começa com j"
grep -E 'sshd\[.*\]: .*Accepted .* for j[[:alnum:]_.-]*\b' auth.log

echo "login via root"
grep -E 'sshd\[.*\]: .*root' auth.log

echo "Logins sucedidos no dia 29 de Setembro"
grep -E '(2025-09-29).*sshd\[.*\]: .*Accepted' auth.log

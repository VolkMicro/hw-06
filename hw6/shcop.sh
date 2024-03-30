
# Список IP-адресов удаленных машин
remote_hosts=("10.128.0.21" "10.128.0.34" "10.128.0.7")

# Открытый ключ пользователя ansible
public_key=$(cat ~/.ssh/id_rsa.pub)

# Цикл для копирования ключа на каждую удаленную машину
for host in "${remote_hosts[@]}"; do
    echo "Copying public key to $host ..."
    # Команда sshpass используется для выполнения команд с привилегиями root без ввода пароля вручную
    sshpass -p "$root_password" ssh root@$host "mkdir -p /home/ansible/.ssh && echo '$public_key' >> /home/ansible/.ssh/authorized_keys && chown -R ansible:ansible /home/ansible/.ssh && chmod 700 /home/ansible/.ssh && chmod 600 /home/ansible/.ssh/authorized_keys"
    echo "Public key copied to $host"
done

echo "Key copying process completed."

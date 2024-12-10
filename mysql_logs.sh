#!/bin/bash

#run mysql_logs on

# Cấu hình MySQL
MYSQL_USER="root"
MYSQL_PASS="vanchuc97"  # Thay bằng mật khẩu MySQL của bạn

# Tên file log
GENERAL_LOG="/var/log/mysql/general.log"
SLOW_LOG="/var/log/mysql/slow.log"
ERROR_LOG="/var/log/mysql/error.log"

# Kiểm tra tham số đầu vào
if [ "$1" == "on" ]; then
    echo "Bật các file log trong MySQL..."

    mysql -u $MYSQL_USER -p$MYSQL_PASS -e "
    SET GLOBAL general_log = 'ON';
    SET GLOBAL general_log_file = '$GENERAL_LOG';

    SET GLOBAL slow_query_log = 'ON';
    SET GLOBAL slow_query_log_file = '$SLOW_LOG';
    SET GLOBAL long_query_time = 2;

    SHOW VARIABLES LIKE '%log%';
    "

    echo "Log đã được bật:"
    echo "General Log: $GENERAL_LOG"
    echo "Slow Query Log: $SLOW_LOG"
    echo "Error Log: $ERROR_LOG"
    echo "Đang theo dõi log truy vấn chung..."
    tail -f $GENERAL_LOG

elif [ "$1" == "off" ]; then
    echo "Tắt các file log trong MySQL..."

    mysql -u $MYSQL_USER -p$MYSQL_PASS -e "
    SET GLOBAL general_log = 'OFF';
    SET GLOBAL slow_query_log = 'OFF';
    SHOW VARIABLES LIKE '%log%';
    "

    echo "Log đã được tắt!"
else
    echo "Sử dụng: $0 [on|off]"
    echo "  on  - Bật log MySQL"
    echo "  off - Tắt log MySQL"
fi

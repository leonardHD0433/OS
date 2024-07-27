CREATE DATABASE IF NOT EXISTS patient_record;
CREATE DATABASE IF NOT EXISTS wordpress;

GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';

-- Apply the changes
FLUSH PRIVILEGES;
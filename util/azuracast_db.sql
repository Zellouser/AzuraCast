CREATE TABLE action (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(100) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE analytics (id INT AUTO_INCREMENT NOT NULL, station_id INT DEFAULT NULL, type VARCHAR(15) NOT NULL, timestamp INT NOT NULL, number_min INT NOT NULL, number_max INT NOT NULL, number_avg INT NOT NULL, INDEX IDX_EAC2E68821BDB235 (station_id), INDEX search_idx (type, timestamp), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE api_keys (id VARCHAR(50) NOT NULL, owner VARCHAR(150) DEFAULT NULL, calls_made INT NOT NULL, created INT NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE role (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(100) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE role_has_action (role_id INT NOT NULL, action_id INT NOT NULL, INDEX IDX_E4DAF125D60322AC (role_id), INDEX IDX_E4DAF1259D32F035 (action_id), PRIMARY KEY(role_id, action_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE settings (setting_key VARCHAR(64) NOT NULL, setting_value LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)', PRIMARY KEY(setting_key)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE songs (id VARCHAR(50) NOT NULL, text VARCHAR(150) DEFAULT NULL, artist VARCHAR(150) DEFAULT NULL, title VARCHAR(150) DEFAULT NULL, created INT NOT NULL, play_count INT NOT NULL, last_played INT NOT NULL, INDEX search_idx (text, artist, title), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE song_history (id INT AUTO_INCREMENT NOT NULL, song_id VARCHAR(50) NOT NULL, station_id INT NOT NULL, timestamp_start INT NOT NULL, listeners_start INT DEFAULT NULL, timestamp_end INT NOT NULL, listeners_end SMALLINT DEFAULT NULL, delta_total SMALLINT NOT NULL, delta_positive SMALLINT NOT NULL, delta_negative SMALLINT NOT NULL, delta_points LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)', INDEX IDX_2AD16164A0BDB2F3 (song_id), INDEX IDX_2AD1616421BDB235 (station_id), INDEX sort_idx (timestamp_start), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE station (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(100) DEFAULT NULL, frontend_type VARCHAR(100) DEFAULT NULL, frontend_config LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)', backend_type VARCHAR(100) DEFAULT NULL, backend_config LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)', description LONGTEXT DEFAULT NULL, radio_base_dir VARCHAR(255) DEFAULT NULL, nowplaying_data LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)', automation_settings LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)', automation_timestamp INT DEFAULT NULL, enable_requests TINYINT(1) NOT NULL, request_delay INT DEFAULT NULL, enable_streamers TINYINT(1) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE station_media (id INT AUTO_INCREMENT NOT NULL, station_id INT NOT NULL, song_id VARCHAR(50) DEFAULT NULL, title VARCHAR(200) DEFAULT NULL, artist VARCHAR(200) DEFAULT NULL, album VARCHAR(200) DEFAULT NULL, length SMALLINT NOT NULL, length_text VARCHAR(10) DEFAULT NULL, path VARCHAR(255) DEFAULT NULL, mtime INT DEFAULT NULL, INDEX IDX_32AADE3A21BDB235 (station_id), INDEX IDX_32AADE3AA0BDB2F3 (song_id), INDEX search_idx (title, artist, album), UNIQUE INDEX path_unique_idx (path), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE station_playlist_has_media (media_id INT NOT NULL, playlists_id INT NOT NULL, INDEX IDX_668E6486EA9FDD75 (media_id), INDEX IDX_668E64869F70CF56 (playlists_id), PRIMARY KEY(media_id, playlists_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE station_playlists (id INT AUTO_INCREMENT NOT NULL, station_id INT NOT NULL, name VARCHAR(200) NOT NULL, type VARCHAR(50) NOT NULL, is_enabled TINYINT(1) NOT NULL, play_per_songs SMALLINT NOT NULL, play_per_minutes SMALLINT NOT NULL, schedule_start_time SMALLINT NOT NULL, schedule_end_time SMALLINT NOT NULL, play_once_time SMALLINT NOT NULL, weight SMALLINT NOT NULL, include_in_automation TINYINT(1) NOT NULL, INDEX IDX_DC827F7421BDB235 (station_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE station_requests (id INT AUTO_INCREMENT NOT NULL, station_id INT NOT NULL, track_id INT NOT NULL, timestamp INT NOT NULL, played_at INT NOT NULL, ip VARCHAR(40) NOT NULL, INDEX IDX_F71F0C0721BDB235 (station_id), INDEX IDX_F71F0C075ED23C43 (track_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE station_streamers (id INT AUTO_INCREMENT NOT NULL, station_id INT NOT NULL, streamer_username VARCHAR(50) NOT NULL, streamer_password VARCHAR(50) NOT NULL, comments LONGTEXT DEFAULT NULL, is_active TINYINT(1) NOT NULL, INDEX IDX_5170063E21BDB235 (station_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE users (uid INT AUTO_INCREMENT NOT NULL, email VARCHAR(100) DEFAULT NULL, auth_password VARCHAR(255) DEFAULT NULL, auth_last_login_time INT DEFAULT NULL, auth_recovery_code VARCHAR(50) DEFAULT NULL, name VARCHAR(100) DEFAULT NULL, gender VARCHAR(1) DEFAULT NULL, customization LONGTEXT DEFAULT NULL COMMENT '(DC2Type:json)', PRIMARY KEY(uid)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE user_has_role (user_id INT NOT NULL, role_id INT NOT NULL, INDEX IDX_EAB8B535A76ED395 (user_id), INDEX IDX_EAB8B535D60322AC (role_id), PRIMARY KEY(user_id, role_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
CREATE TABLE user_manages_station (user_id INT NOT NULL, station_id INT NOT NULL, INDEX IDX_2453B56BA76ED395 (user_id), INDEX IDX_2453B56B21BDB235 (station_id), PRIMARY KEY(user_id, station_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB;
ALTER TABLE analytics ADD CONSTRAINT FK_EAC2E68821BDB235 FOREIGN KEY (station_id) REFERENCES station (id) ON DELETE CASCADE;
ALTER TABLE role_has_action ADD CONSTRAINT FK_E4DAF125D60322AC FOREIGN KEY (role_id) REFERENCES role (id) ON DELETE CASCADE;
ALTER TABLE role_has_action ADD CONSTRAINT FK_E4DAF1259D32F035 FOREIGN KEY (action_id) REFERENCES action (id) ON DELETE CASCADE;
ALTER TABLE song_history ADD CONSTRAINT FK_2AD16164A0BDB2F3 FOREIGN KEY (song_id) REFERENCES songs (id) ON DELETE CASCADE;
ALTER TABLE song_history ADD CONSTRAINT FK_2AD1616421BDB235 FOREIGN KEY (station_id) REFERENCES station (id) ON DELETE CASCADE;
ALTER TABLE station_media ADD CONSTRAINT FK_32AADE3A21BDB235 FOREIGN KEY (station_id) REFERENCES station (id) ON DELETE CASCADE;
ALTER TABLE station_media ADD CONSTRAINT FK_32AADE3AA0BDB2F3 FOREIGN KEY (song_id) REFERENCES songs (id) ON DELETE SET NULL;
ALTER TABLE station_playlist_has_media ADD CONSTRAINT FK_668E6486EA9FDD75 FOREIGN KEY (media_id) REFERENCES station_media (id) ON DELETE CASCADE;
ALTER TABLE station_playlist_has_media ADD CONSTRAINT FK_668E64869F70CF56 FOREIGN KEY (playlists_id) REFERENCES station_playlists (id) ON DELETE CASCADE;
ALTER TABLE station_playlists ADD CONSTRAINT FK_DC827F7421BDB235 FOREIGN KEY (station_id) REFERENCES station (id) ON DELETE CASCADE;
ALTER TABLE station_requests ADD CONSTRAINT FK_F71F0C0721BDB235 FOREIGN KEY (station_id) REFERENCES station (id) ON DELETE CASCADE;
ALTER TABLE station_requests ADD CONSTRAINT FK_F71F0C075ED23C43 FOREIGN KEY (track_id) REFERENCES station_media (id) ON DELETE CASCADE;
ALTER TABLE station_streamers ADD CONSTRAINT FK_5170063E21BDB235 FOREIGN KEY (station_id) REFERENCES station (id) ON DELETE CASCADE;
ALTER TABLE user_has_role ADD CONSTRAINT FK_EAB8B535A76ED395 FOREIGN KEY (user_id) REFERENCES users (uid) ON DELETE CASCADE;
ALTER TABLE user_has_role ADD CONSTRAINT FK_EAB8B535D60322AC FOREIGN KEY (role_id) REFERENCES role (id) ON DELETE CASCADE;
ALTER TABLE user_manages_station ADD CONSTRAINT FK_2453B56BA76ED395 FOREIGN KEY (user_id) REFERENCES users (uid) ON DELETE CASCADE;
ALTER TABLE user_manages_station ADD CONSTRAINT FK_2453B56B21BDB235 FOREIGN KEY (station_id) REFERENCES station (id) ON DELETE CASCADE;
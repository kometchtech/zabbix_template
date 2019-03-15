Zabbix PowerDNS recursor
============

#### 概要 ###
　PowerDNS recursorの rec_control の機能を利用し値を一括で取得するとともに、
　Zabbix Senderで一括でZabbix Serverで値を送信する。
　
#### 使い方 ####
　Zabbix_sender向け
　	zbx_send_pdns_rec.sh、zbx_export_templates_pdns_rec.xml
　	
　Zabbix UserParamter向け
　	userparameter_pdns_rec.conf、zbx_export_templates_pdns_rec_up.xml
　
### 注意 ###

- ファイルに書き込む関係で、取得時間が若干ズレています。上手いアイディア募集中。
- 中間ファイルを書き込まない方法はないものか。

### 更新履歴 ###

	・1.0　公開
	・1.1　UserParamter用テンプレート、Userparameter用confを追加

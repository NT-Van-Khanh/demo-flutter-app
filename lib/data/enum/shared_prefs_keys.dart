enum SharedPrefsKeys {
  AUTH_TOKEN("auth_token"),
  LOGIN_TYPE("login_type"),
  USER_ID("user_id"),
  IS_LOGGED_IN("is_logged_in"),
  THEME_MODE("theme_mode"),
  LANGUAGE("language");

  final String value;
  const SharedPrefsKeys(this.value);
}

PATH=$PATH:$HOME/.local/bin
PATH=$PATH:/usr/local/go/bin
M2_HOME=/usr/local/apache-maven/apache-maven-3.8.8
M2=$M2_HOME/bin
PATH=$M2:$PATH

enable_jdk17(){
  echo "Enable jdk 17 using sdkman. Please double confirm you itsma-x is in correct branch"
  sdk default java 17.0.7-zulu
  sed -i '/CATALINA_HOME=/c\export CATALINA_HOME=/opt/tomcat10/' ~/.zshenv
  source ~/.zshenv
  echo "JAVA_HOME is: $JAVA_HOME"
  echo "CATALINA_HOME is: $CATALINA_HOME"
  yq -i '.default.jdk_version = 17' "$HOME/.omw/config/conf.yaml"
  yq -i '.default.version = "2.0.0-9999-SNAPSHOT"' "$HOME/.omw/config/conf.yaml"
  mvn -v
  cat "$HOME/.omw/config/conf.yaml"
  echo "check JAVA_HOME, CATALINA_HOME, jdk_version in conf.yaml; If all settings correct, you can run omw start"
}

enable_jdk8(){
  echo "Enable jdk 8 using sdkman. Please double confirm you itsma-x is in correct branch"
  sdk default java 8.0.392-zulu
  sed -i '/CATALINA_HOME=/c\export CATALINA_HOME=/opt/apache-tomcat/' ~/.zshenv
  source ~/.zshenv
  echo "JAVA_HOME is: $JAVA_HOME"
  echo "CATALINA_HOME is: $CATALINA_HOME"
  yq -i '.default.jdk_version = 8' "$HOME/.omw/config/conf.yaml"
  yq -i '.default.version = "1.0.0-9999-SNAPSHOT"' "$HOME/.omw/config/conf.yaml"
  mvn -v
  cat "$HOME/.omw/config/conf.yaml"
  echo "check JAVA_HOME, CATALINA_HOME, jdk_version in conf.yaml; If all settings correct, you can run omw start"
}

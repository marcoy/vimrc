name := ""

organization := "com.marcoy"

version := "0.0.1"

scalaVersion := "2.9.0-1"

scalacOptions ++= Seq( "-deprecation" )

libraryDependencies ++= Seq(

)

resolvers ++= Seq(
  "Akka Maven Repository" at "http://akka.io/repository",
  "Maven Repository 1"    at "http://repo1.maven.org/maven2/",
  "Maven Repository 2"    at "http://repo2.maven.org/maven2/",
  "ibiblio Repository"    at "http://mirrors.ibiblio.org/pub/mirrors/maven2/"
)

// vim: set ft=scala:


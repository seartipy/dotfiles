resolvers += Resolver.sonatypeRepo("snapshots")

addSbtPlugin("org.ensime" % "sbt-ensime" % "1.11.1")

addSbtPlugin("com.typesafe.sbteclipse" % "sbteclipse-plugin" % "5.0.1")

// addSbtPlugin("de.heikoseeberger" % "sbt-groll" % "4.9.0")

// addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.8.2")

addSbtPlugin("com.timushev.sbt" % "sbt-updates" % "0.1.10")

addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0-M14")

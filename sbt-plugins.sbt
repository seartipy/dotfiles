resolvers += Resolver.sonatypeRepo("snapshots")

addSbtPlugin("org.ensime" % "sbt-ensime" % "1.12.4")

addSbtPlugin("com.typesafe.sbteclipse" % "sbteclipse-plugin" % "5.0.1")

// addSbtPlugin("de.heikoseeberger" % "sbt-groll" % "4.9.0")

// addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.8.2")

addSbtPlugin("com.timushev.sbt" % "sbt-updates" % "0.3.0")

addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0-M15")

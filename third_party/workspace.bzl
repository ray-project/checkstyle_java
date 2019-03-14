# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output=ctx.path("jar/%s" % jar_name),
        url=ctx.attr.urls,
        sha256=ctx.attr.sha256,
        executable=False
    )
    src_name="%s-sources.jar" % ctx.name
    srcjar_attr=""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output=ctx.path("jar/%s" % src_name),
            url=ctx.attr.src_urls,
            sha256=ctx.attr.src_sha256,
            executable=False
        )
        srcjar_attr ='\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])

def list_dependencies():
    return [
    {"artifact": "antlr:antlr:2.7.7", "lang": "java", "sha1": "83cd2cd674a217ade95a4bb83a8a14f351f48bd0", "sha256": "88fbda4b912596b9f56e8e12e580cc954bacfb51776ecfddd3e18fc1cf56dc4c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/antlr/antlr/2.7.7/antlr-2.7.7.jar", "name": "antlr_antlr", "actual": "@antlr_antlr//jar", "bind": "jar/antlr/antlr"},
    {"artifact": "com.google.code.findbugs:jsr305:3.0.2", "lang": "java", "sha1": "25ea2e8b0c338a877313bd4672d3fe056ea78f0d", "sha256": "766ad2a0783f2687962c8ad74ceecc38a28b9f72a2d085ee438b7813e928d0c7", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar", "source": {"sha1": "b19b5927c2c25b6c70f093767041e641ae0b1b35", "sha256": "1c9e85e272d0708c6a591dc74828c71603053b48cc75ae83cce56912a2aa063b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2-sources.jar"} , "name": "com_google_code_findbugs_jsr305", "actual": "@com_google_code_findbugs_jsr305//jar", "bind": "jar/com/google/code/findbugs/jsr305"},
    {"artifact": "com.google.errorprone:error_prone_annotations:2.2.0", "lang": "java", "sha1": "88e3c593e9b3586e1c6177f89267da6fc6986f0c", "sha256": "6ebd22ca1b9d8ec06d41de8d64e0596981d9607b42035f9ed374f9de271a481a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.2.0/error_prone_annotations-2.2.0.jar", "source": {"sha1": "a8cd7823aa1dcd2fd6677c0c5988fdde9d1fb0a3", "sha256": "626adccd4894bee72c3f9a0384812240dcc1282fb37a87a3f6cb94924a089496", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.2.0/error_prone_annotations-2.2.0-sources.jar"} , "name": "com_google_errorprone_error_prone_annotations", "actual": "@com_google_errorprone_error_prone_annotations//jar", "bind": "jar/com/google/errorprone/error_prone_annotations"},
    {"artifact": "com.google.guava:failureaccess:1.0.1", "lang": "java", "sha1": "1dcf1de382a0bf95a3d8b0849546c88bac1292c9", "sha256": "a171ee4c734dd2da837e4b16be9df4661afab72a41adaf31eb84dfdaf936ca26", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar", "source": {"sha1": "1d064e61aad6c51cc77f9b59dc2cccc78e792f5a", "sha256": "092346eebbb1657b51aa7485a246bf602bb464cc0b0e2e1c7e7201fadce1e98f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1-sources.jar"} , "name": "com_google_guava_failureaccess", "actual": "@com_google_guava_failureaccess//jar", "bind": "jar/com/google/guava/failureaccess"},
    {"artifact": "com.google.guava:guava:27.0.1-jre", "lang": "java", "sha1": "bd41a290787b5301e63929676d792c507bbc00ae", "sha256": "e1c814fd04492a27c38e0317eabeaa1b3e950ec8010239e400fe90ad6c9107b4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/27.0.1-jre/guava-27.0.1-jre.jar", "source": {"sha1": "cb5c1119df8d41a428013289b193eba3ccaf5f60", "sha256": "cba2e5680186062f42998b895a5e9a9ceccbaab94644ccc9f35bb73c2b2c7d8e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/27.0.1-jre/guava-27.0.1-jre-sources.jar"} , "name": "com_google_guava_guava", "actual": "@com_google_guava_guava//jar", "bind": "jar/com/google/guava/guava"},
    {"artifact": "com.google.guava:listenablefuture:9999.0-empty-to-avoid-conflict-with-guava", "lang": "java", "sha1": "b421526c5f297295adef1c886e5246c39d4ac629", "sha256": "b372a037d4230aa57fbeffdef30fd6123f9c0c2db85d0aced00c91b974f33f99", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar", "name": "com_google_guava_listenablefuture", "actual": "@com_google_guava_listenablefuture//jar", "bind": "jar/com/google/guava/listenablefuture"},
    {"artifact": "com.google.j2objc:j2objc-annotations:1.1", "lang": "java", "sha1": "ed28ded51a8b1c6b112568def5f4b455e6809019", "sha256": "2994a7eb78f2710bd3d3bfb639b2c94e219cedac0d4d084d516e78c16dddecf6", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1.jar", "source": {"sha1": "1efdf5b737b02f9b72ebdec4f72c37ec411302ff", "sha256": "2cd9022a77151d0b574887635cdfcdf3b78155b602abc89d7f8e62aba55cfb4f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1-sources.jar"} , "name": "com_google_j2objc_j2objc_annotations", "actual": "@com_google_j2objc_j2objc_annotations//jar", "bind": "jar/com/google/j2objc/j2objc_annotations"},
    {"artifact": "com.puppycrawl.tools:checkstyle:8.15", "lang": "java", "sha1": "8584d88c6aefcfb079adb8d102928b3eeb4de6ad", "sha256": "ac3602c4d50c3113b14614a6ac38ec03c63d9839e4316e057c4bb66d97183087", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/puppycrawl/tools/checkstyle/8.15/checkstyle-8.15.jar", "source": {"sha1": "1c1865dc6d20a1abc14ea7721fcbc78e2563d4ca", "sha256": "6745eda6450aa6e8609e56499fd56f515402a2ace3c7bd0345ec9b3f6eb8f6f6", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/puppycrawl/tools/checkstyle/8.15/checkstyle-8.15-sources.jar"} , "name": "com_puppycrawl_tools_checkstyle", "actual": "@com_puppycrawl_tools_checkstyle//jar", "bind": "jar/com/puppycrawl/tools/checkstyle"},
    {"artifact": "commons-beanutils:commons-beanutils:1.9.3", "lang": "java", "sha1": "c845703de334ddc6b4b3cd26835458cb1cba1f3d", "sha256": "c058e39c7c64203d3a448f3adb588cb03d6378ed808485618f26e137f29dae73", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/commons-beanutils/commons-beanutils/1.9.3/commons-beanutils-1.9.3.jar", "source": {"sha1": "9d70af7c5982bd09c33efa97ac98cee6363ba0f0", "sha256": "3315f25f3793c1bb2577b2d956f58f852c7386c73aff4dea450e419a80b00a41", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/commons-beanutils/commons-beanutils/1.9.3/commons-beanutils-1.9.3-sources.jar"} , "name": "commons_beanutils_commons_beanutils", "actual": "@commons_beanutils_commons_beanutils//jar", "bind": "jar/commons_beanutils/commons_beanutils"},
    {"artifact": "commons-collections:commons-collections:3.2.2", "lang": "java", "sha1": "8ad72fe39fa8c91eaaf12aadb21e0c3661fe26d5", "sha256": "eeeae917917144a68a741d4c0dff66aa5c5c5fd85593ff217bced3fc8ca783b8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/commons-collections/commons-collections/3.2.2/commons-collections-3.2.2.jar", "source": {"sha1": "78c50ebda5784937ca1615fc0e1d0cb35857d572", "sha256": "a5b5ee16a02edadf7fe637f250217c19878bc6134f15eb55635c48996f6fed1d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/commons-collections/commons-collections/3.2.2/commons-collections-3.2.2-sources.jar"} , "name": "commons_collections_commons_collections", "actual": "@commons_collections_commons_collections//jar", "bind": "jar/commons_collections/commons_collections"},
    {"artifact": "commons-logging:commons-logging:1.2", "lang": "java", "sha1": "4bfc12adfe4842bf07b657f0369c4cb522955686", "sha256": "daddea1ea0be0f56978ab3006b8ac92834afeefbd9b7e4e6316fca57df0fa636", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/commons-logging/commons-logging/1.2/commons-logging-1.2.jar", "source": {"sha1": "ecf26c7507d67782a3bbd148d170b31dfad001aa", "sha256": "44347acfe5860461728e9cb33251e97345be36f8a0dfd5c5130c172559455f41", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/commons-logging/commons-logging/1.2/commons-logging-1.2-sources.jar"} , "name": "commons_logging_commons_logging", "actual": "@commons_logging_commons_logging//jar", "bind": "jar/commons_logging/commons_logging"},
    {"artifact": "info.picocli:picocli:3.8.0", "lang": "java", "sha1": "86d47318b178e9e1d8b600a7afd1b8bd36300d3c", "sha256": "2b615ea91a8487d630efb7d3b04cab334d30ca414575138ce94201d470450fc4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/info/picocli/picocli/3.8.0/picocli-3.8.0.jar", "source": {"sha1": "6fbfd760f8ed0bc04ac7311c52878c25eed81176", "sha256": "a23d58cf6c90bbd5568dbd7bb519b7225377ec2330315da0c8c4e623fc3dbf05", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/info/picocli/picocli/3.8.0/picocli-3.8.0-sources.jar"} , "name": "info_picocli_picocli", "actual": "@info_picocli_picocli//jar", "bind": "jar/info/picocli/picocli"},
    {"artifact": "net.sf.saxon:Saxon-HE:9.9.0-2", "lang": "java", "sha1": "c3437344acc4d2f1b5d1a638166e6ce52b300595", "sha256": "34661e9c6dd69caff14ec31e3ec47a9e7dbbc08be9da2c6326daf4e0038ed97c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/sf/saxon/Saxon-HE/9.9.0-2/Saxon-HE-9.9.0-2.jar", "source": {"sha1": "294ea53dfb38f001372deee809c375e8736f16f4", "sha256": "b229a09b43c67690eeba0344840cd3a053bb1946ebcd668b9764ef454ed7d1cf", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/sf/saxon/Saxon-HE/9.9.0-2/Saxon-HE-9.9.0-2-sources.jar"} , "name": "net_sf_saxon_Saxon_HE", "actual": "@net_sf_saxon_Saxon_HE//jar", "bind": "jar/net/sf/saxon/Saxon_HE"},
    {"artifact": "org.antlr:antlr4-runtime:4.7.1", "lang": "java", "sha1": "946f8aa9daa917dd81a8b818111bec7e288f821a", "sha256": "43516d19beae35909e04d06af6c0c58c17bc94e0070c85e8dc9929ca640dc91d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/antlr/antlr4-runtime/4.7.1/antlr4-runtime-4.7.1.jar", "source": {"sha1": "1e68e18aa14f3229b95820d354a594846134af38", "sha256": "a33d52d0d64e68c60d5e3ae2c1098fe7200d57cff59032c19930fd9d487fc7d4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/antlr/antlr4-runtime/4.7.1/antlr4-runtime-4.7.1-sources.jar"} , "name": "org_antlr_antlr4_runtime", "actual": "@org_antlr_antlr4_runtime//jar", "bind": "jar/org/antlr/antlr4_runtime"},
    {"artifact": "org.checkerframework:checker-qual:2.5.2", "lang": "java", "sha1": "cea74543d5904a30861a61b4643a5f2bb372efc4", "sha256": "64b02691c8b9d4e7700f8ee2e742dce7ea2c6e81e662b7522c9ee3bf568c040a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/checkerframework/checker-qual/2.5.2/checker-qual-2.5.2.jar", "source": {"sha1": "ebb8ebccd42218434674f3e1d9022c13df1c19f8", "sha256": "821c5c63a6f156a3bb498c5bbb613580d9d8f4134131a5627d330fc4018669d2", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/checkerframework/checker-qual/2.5.2/checker-qual-2.5.2-sources.jar"} , "name": "org_checkerframework_checker_qual", "actual": "@org_checkerframework_checker_qual//jar", "bind": "jar/org/checkerframework/checker_qual"},
    {"artifact": "org.codehaus.mojo:animal-sniffer-annotations:1.17", "lang": "java", "sha1": "f97ce6decaea32b36101e37979f8b647f00681fb", "sha256": "92654f493ecfec52082e76354f0ebf87648dc3d5cec2e3c3cdb947c016747a53", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.17/animal-sniffer-annotations-1.17.jar", "source": {"sha1": "8fb5b5ad9c9723951b9fccaba5bb657fa6064868", "sha256": "2571474a676f775a8cdd15fb9b1da20c4c121ed7f42a5d93fca0e7b6e2015b40", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.17/animal-sniffer-annotations-1.17-sources.jar"} , "name": "org_codehaus_mojo_animal_sniffer_annotations", "actual": "@org_codehaus_mojo_animal_sniffer_annotations//jar", "bind": "jar/org/codehaus/mojo/animal_sniffer_annotations"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)

#
# Copyright 2012-2014 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "gettext"
default_version "0.20.1"

license "MIT"
license_file "README"
skip_transitive_dependency_licensing true


version "0.20.1" do
  source md5: "9ed9e26ab613b668e0026222a9c23639"
end

# ftp on ftp.ossp.org is unavaiable so we must use another mirror site.
source url: "https://ftp.gnu.org/gnu/gettext/gettext-0.20.1.tar.xz"

relative_path "gettext-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess

  command "./configure" \
            "--disable-dependency-tracking" \
            "--disable-silent-rules" \
            "--disable-debug" \
            "--prefix=#{install_dir}/embedded" \
            "--with-included-gettext" \
            # Work around a gnulib issue with macOS Catalina
            "gl_cv_func_ftello_works=yes" \
            "--with-included-glib" \
            "--with-included-libcroco" \
            "--with-included-libunistring" \
            "--with-emacs" \
            "--disable-java" \
            "--disable-csharp" \
            # Don't use VCS systems to create these archives
            "--without-git"\ 
            "--without-cvs"\
            "--without-xz", env: env

  make "-j #{workers}", env: env
  make "install", env: env

end

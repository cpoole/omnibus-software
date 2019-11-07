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

name "e2fsprogs"
default_version "1.44.5"

license "MIT"
license_file "README"
skip_transitive_dependency_licensing true


version "1.44.5" do
  source md5: "8d78b11d04d26c0b2dd149529441fa80"
end

# ftp on ftp.ossp.org is unavaiable so we must use another mirror site.
source url: "https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.44.5/e2fsprogs-1.44.5.tar.gz"

relative_path "uuid-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess

  command "./configure" \
          " --prefix=#{install_dir}/embedded"\
          " --disable-e2initrd-helper" \
          " MKDIR_P=mkdir -p", env: env

  make "-j #{workers}", env: env
  make "install", env: env
  make "install-libs", env: env

end

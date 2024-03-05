EAPI=8

inherit desktop toolchain-funcs

DESCRIPTION="A multi-system emulator focusing on accuracy and game preservation."
HOMEPAGE="https://github.com/ares-emulator/ares https://ares-emu.net/"
SRC_URI="https://github.com/ares-emulator/ares/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ares"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+opengl +sdl +alsa libao openal gtk2 +gtk3"

RDEPEND="
    opengl? (
		virtual/opengl
	)
    sdl? (
		media-libs/libsdl2
	)
    alsa? ( media-libs/alsa-lib )
    libao? ( media-libs/libao )
    openal? ( media-libs/openal )
    media-libs/libcanberra
	gtk2? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )"
DEPEND="${RDEPEND}"
BDEPEND="
    virtual/pkgconfig
    sys-devel/gcc"

src_compile() {
	local makeopts=(
		hiro=$(usex gtk2 gtk2 gtk3 )
	)

	local coreopts=(
		cores="a26 fc sfc n64 sg ms md ps1 pce ng msx cv myvision gb gba ws ngp spec"
	)

	emake "${makeopts[@]}" "${coreopts[@]}" -C desktop-ui
}

src_install() {
        dobin desktop-ui/out/ares
	domenu desktop-ui/resource/ares.desktop
	doicon desktop-ui/resource/ares.png

	insinto /usr/share/ares
	doins -r ares/Shaders
	doins -r mia/Database
}

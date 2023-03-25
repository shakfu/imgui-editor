cmake_minimum_required(VERSION 3.23)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS OFF)
# set(CMAKE_BUILD_TYPE "Release")

project(
  imgui_editor
  VERSION 0.0.1
  DESCRIPTION "minimal imgui editor"
  HOMEPAGE_URL "https://github.com/shakfu/imgui-editor"
  LANGUAGES CXX C
)

set(EXE "editor")
set(IMGUI_DIR "src/imgui")
set(EDITOR_DIR "src/texteditor")


add_executable(editor
	# main
	main.mm

	# imgui core
	${IMGUI_DIR}/imgui.cpp
	${IMGUI_DIR}/imgui_demo.cpp
	${IMGUI_DIR}/imgui_draw.cpp
	${IMGUI_DIR}/imgui_tables.cpp
	${IMGUI_DIR}/imgui_widgets.cpp

	# imgui backends
	${IMGUI_DIR}/backends/imgui_impl_glfw.cpp
	${IMGUI_DIR}/backends/imgui_impl_metal.mm

	# imgui editor
	${EDITOR_DIR}/TextEditor.cpp
	${EDITOR_DIR}/LanguageDefinitions.cpp
)

target_include_directories(${EXE} PRIVATE
	/usr/local/include
	${IMGUI_DIR}
	${IMGUI_DIR}/backends
	${EDITOR_DIR}
)

target_compile_options(${EXE} PRIVATE
	-std=c++17
	-Wall
	-Wformat
)

# target_link_options(${EXE} PRIVATE
# )

target_link_libraries(${EXE} PRIVATE
	"-framework Metal"
	"-framework MetalKit"
	"-framework Cocoa"
	"-framework IOKit"
	"-framework CoreVideo"
	"-framework QuartzCore"
	"-lglfw"
)

target_link_directories(${EXE} PRIVATE
    /usr/local/lib
)


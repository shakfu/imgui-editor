#
# You will need GLFW (http://www.glfw.org):
#   brew install glfw
#

#CXX = g++
#CXX = clang++

EXE = example_glfw_metal
IMGUI_DIR = src/imgui
EDITOR_DIR = src/texteditor
SOURCES = main.mm
HOMEBREW_PREFIX=$(shell brew --prefix)

SOURCES += $(IMGUI_DIR)/imgui.cpp \
		   $(IMGUI_DIR)/imgui_demo.cpp \
		   $(IMGUI_DIR)/imgui_draw.cpp \
		   $(IMGUI_DIR)/imgui_tables.cpp \
		   $(IMGUI_DIR)/imgui_widgets.cpp

SOURCES += $(IMGUI_DIR)/backends/imgui_impl_glfw.cpp \
		   $(IMGUI_DIR)/backends/imgui_impl_metal.mm


SOURCES += ${EDITOR_DIR}/TextEditor.cpp \
		   ${EDITOR_DIR}/LanguageDefinitions.cpp
# 		   ImGuiDebugPanel.cpp

OBJS = $(addsuffix .o, $(basename $(notdir $(SOURCES))))

LIBS = -framework Metal -framework MetalKit -framework Cocoa -framework IOKit -framework CoreVideo -framework QuartzCore
LIBS += -L/usr/local/lib -L${HOMEBREW_PREFIX}/lib
LIBS += -lglfw

CXXFLAGS = -std=c++17 -I$(IMGUI_DIR) -I$(IMGUI_DIR)/backends -I$(EDITOR_DIR) -I/usr/local/include -I$(HOMEBREW_PREFIX)/include
CXXFLAGS += -Wall -Wformat
CFLAGS = $(CXXFLAGS)

%.o:%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

%.o:$(IMGUI_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

%.o:$(IMGUI_DIR)/backends/%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

%.o:$(EDITOR_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

%.o:%.mm
	$(CXX) $(CXXFLAGS) -ObjC++ -fobjc-weak -fobjc-arc -c -o $@ $<

%.o:$(IMGUI_DIR)/backends/%.mm
	$(CXX) $(CXXFLAGS) -ObjC++ -fobjc-weak -fobjc-arc -c -o $@ $<

all: $(EXE)
	@echo Build complete

$(EXE): $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS) $(LIBS)

clean:
	rm -f $(EXE) $(OBJS)

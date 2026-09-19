#define HL_NAME(n) glfw_##n
#include <hl.h>

#undef HL_PRIM
#ifdef _WIN32
#define HL_PRIM extern "C" __declspec(dllexport)
#else
#define HL_PRIM extern "C" __attribute__((visibility("default")))
#endif

#undef DEFINE_PRIM_WITH_NAME
#ifdef STATIC_HDLL
#define DEFINE_PRIM_WITH_NAME(t,name,args,realName)
#else
#define DEFINE_PRIM_WITH_NAME(t,name,args,realName) \
    HL_EXTERN_C HL_EXPORT void *hlp_##realName( const char **sign ) { *sign = _FUN(t,args); return (void*)(&HL_NAME(realName)); }
#endif

#include "GLFW/glfw3.h"
#include <string.h>

static void glfw_call_haxe(vclosure *cb, vdynamic **args, int nargs) {
	if (cb == NULL) return;
	bool isException = false;
	vdynamic *ret = hl_dyn_call_safe(cb, args, nargs, &isException);
	if (isException) hl_print_uncaught_exception(ret);
}

HL_PRIM int HL_NAME(init)(void)
{
        return glfwInit();
}
DEFINE_PRIM(_I32, init, _NO_ARG);

HL_PRIM void HL_NAME(terminate)(void)
{
	glfwTerminate();
}
DEFINE_PRIM(_VOID, terminate, _NO_ARG);

HL_PRIM void HL_NAME(init_hint)(int hint, int value)
{
	glfwInitHint(hint, value);
}
DEFINE_PRIM(_VOID, init_hint, _I32 _I32);

HL_PRIM void HL_NAME(init_allocator)(GLFWallocator *allocator)
{
	glfwInitAllocator(allocator);
}
DEFINE_PRIM(_VOID, init_allocator, _ABSTRACT(GLFWallocator));

// TODO: REVIEW (glfwGetVersion):
//   - parameter 'major': pointer to primitive type: out-param o array
//   - parameter 'minor': pointer to primitive type: out-param o array
//   - parameter 'rev': pointer to primitive type: out-param o array
HL_PRIM void HL_NAME(get_version)(vbyte *major, vbyte *minor, vbyte *rev)
{
	glfwGetVersion((int *)major, (int *)minor, (int *)rev);
}
DEFINE_PRIM(_VOID, get_version, _BYTES _BYTES _BYTES);

HL_PRIM vbyte *HL_NAME(get_version_string)(void)
{
	return (vbyte *)glfwGetVersionString();
}
DEFINE_PRIM(_BYTES, get_version_string, _NO_ARG);

// TODO: REVIEW (glfwGetError):
//   - parameter 'description': double pointer: verify use
HL_PRIM int HL_NAME(get_error)(vbyte *description)
{
	return glfwGetError((const char **)description);
}
DEFINE_PRIM(_I32, get_error, _BYTES);

// TODO: REVIEW (glfwSetErrorCallback):
//   - return: callback (function pointer): necesita puente manual
//   - parameter 'callback': callback (function pointer): necesita puente manual
HL_PRIM vbyte *HL_NAME(set_error_callback)(vbyte *callback)
{
	return (vbyte *)glfwSetErrorCallback((void (*)(int, const char *))callback);
}
DEFINE_PRIM(_BYTES, set_error_callback, _BYTES);

HL_PRIM int HL_NAME(get_platform)(void)
{
	return glfwGetPlatform();
}
DEFINE_PRIM(_I32, get_platform, _NO_ARG);

HL_PRIM int HL_NAME(platform_supported)(int platform)
{
	return glfwPlatformSupported(platform);
}
DEFINE_PRIM(_I32, platform_supported, _I32);

// TODO: REVIEW (glfwGetMonitors):
//   - return: double pointer: verify use
//   - parameter 'count': pointer to primitive type: out-param o array
HL_PRIM vbyte *HL_NAME(get_monitors)(vbyte *count)
{
	return (vbyte *)glfwGetMonitors((int *)count);
}
DEFINE_PRIM(_BYTES, get_monitors, _BYTES);

HL_PRIM GLFWmonitor *HL_NAME(get_monitor_at)(int index) {
    int count = 0;
    GLFWmonitor **monitors = glfwGetMonitors(&count);
    if (monitors && index >= 0 && index < count) {
        return monitors[index];
    }
    return NULL;
}
DEFINE_PRIM(_ABSTRACT(GLFWmonitor), get_monitor_at, _I32);

HL_PRIM GLFWmonitor *HL_NAME(get_primary_monitor)(void)
{
	return glfwGetPrimaryMonitor();
}
DEFINE_PRIM(_ABSTRACT(GLFWmonitor), get_primary_monitor, _NO_ARG);

// TODO: REVIEW (glfwGetMonitorPos):
//   - parameter 'xpos': pointer to primitive type: out-param o array
//   - parameter 'ypos': pointer to primitive type: out-param o array
HL_PRIM void HL_NAME(get_monitor_pos)(GLFWmonitor *monitor, vbyte *xpos, vbyte *ypos)
{
	glfwGetMonitorPos(monitor, (int *)xpos, (int *)ypos);
}
DEFINE_PRIM(_VOID, get_monitor_pos, _ABSTRACT(GLFWmonitor) _BYTES _BYTES);

// TODO: REVIEW (glfwGetMonitorWorkarea):
//   - parameter 'xpos': pointer to primitive type: out-param o array
//   - parameter 'ypos': pointer to primitive type: out-param o array
//   - parameter 'width': pointer to primitive type: out-param o array
//   - parameter 'height': pointer to primitive type: out-param o array
HL_PRIM void HL_NAME(get_monitor_workarea)(GLFWmonitor *monitor, vbyte *xpos, vbyte *ypos, vbyte *width, vbyte *height)
{
	glfwGetMonitorWorkarea(monitor, (int *)xpos, (int *)ypos, (int *)width, (int *)height);
}
DEFINE_PRIM(_VOID, get_monitor_workarea, _ABSTRACT(GLFWmonitor) _BYTES _BYTES _BYTES _BYTES);

// TODO: REVIEW (glfwGetMonitorPhysicalSize):
//   - parameter 'widthMM': pointer to primitive type: out-param o array
//   - parameter 'heightMM': pointer to primitive type: out-param o array
HL_PRIM void HL_NAME(get_monitor_physical_size)(GLFWmonitor *monitor, vbyte *widthMM, vbyte *heightMM)
{
	glfwGetMonitorPhysicalSize(monitor, (int *)widthMM, (int *)heightMM);
}
DEFINE_PRIM(_VOID, get_monitor_physical_size, _ABSTRACT(GLFWmonitor) _BYTES _BYTES);

// TODO: REVIEW (glfwGetMonitorContentScale):
//   - parameter 'xscale': pointer to primitive type: out-param o array
//   - parameter 'yscale': pointer to primitive type: out-param o array
HL_PRIM void HL_NAME(get_monitor_content_scale)(GLFWmonitor *monitor, vbyte *xscale, vbyte *yscale)
{
	glfwGetMonitorContentScale(monitor, (float *)xscale, (float *)yscale);
}
DEFINE_PRIM(_VOID, get_monitor_content_scale, _ABSTRACT(GLFWmonitor) _BYTES _BYTES);

HL_PRIM vbyte *HL_NAME(get_monitor_name)(GLFWmonitor *monitor)
{
	return (vbyte *)glfwGetMonitorName(monitor);
}
DEFINE_PRIM(_BYTES, get_monitor_name, _ABSTRACT(GLFWmonitor));

// TODO: REVIEW (glfwSetMonitorUserPointer):
//   - parameter 'pointer': pointer to primitive type: out-param o array
HL_PRIM void HL_NAME(set_monitor_user_pointer)(GLFWmonitor *monitor, vbyte *pointer)
{
	glfwSetMonitorUserPointer(monitor, (void *)pointer);
}
DEFINE_PRIM(_VOID, set_monitor_user_pointer, _ABSTRACT(GLFWmonitor) _BYTES);

// TODO: REVIEW (glfwGetMonitorUserPointer):
//   - return: pointer to primitive type: out-param o array
HL_PRIM vbyte *HL_NAME(get_monitor_user_pointer)(GLFWmonitor *monitor)
{
	return (vbyte *)glfwGetMonitorUserPointer(monitor);
}
DEFINE_PRIM(_BYTES, get_monitor_user_pointer, _ABSTRACT(GLFWmonitor));

static vclosure* g_monitor_cb = NULL;

static void native_monitor_callback(GLFWmonitor* monitor, int event) {
    if (g_monitor_cb == NULL) return;
    
    vdynamic arg0 = { &hlt_abstract, {.ptr = monitor} };
    vdynamic arg1 = { &hlt_i32, {.i = event} };
    vdynamic* args[2] = { &arg0, &arg1 };
    
    glfw_call_haxe(g_monitor_cb, args, 2);
}

HL_PRIM void HL_NAME(set_monitor_callback)(vclosure* callback) {
    if (g_monitor_cb != NULL) hl_remove_root((void**)&g_monitor_cb);
    g_monitor_cb = callback;
    if (g_monitor_cb != NULL) {
        hl_add_root((void**)&g_monitor_cb);
        glfwSetMonitorCallback(native_monitor_callback);
    } else {
        glfwSetMonitorCallback(NULL);
    }
}
DEFINE_PRIM(_VOID, set_monitor_callback, _FUN(_VOID, _ABSTRACT(GLFWmonitor) _I32));

// TODO: REVIEW (glfwGetVideoModes):
//   - parameter 'count': pointer to primitive type: out-param o array
HL_PRIM GLFWvidmode *HL_NAME(get_video_modes)(GLFWmonitor *monitor, vbyte *count)
{
	return (GLFWvidmode *)glfwGetVideoModes(monitor, (int *)count);
}
DEFINE_PRIM(_ABSTRACT(GLFWvidmode), get_video_modes, _ABSTRACT(GLFWmonitor) _BYTES);

HL_PRIM GLFWvidmode *HL_NAME(get_video_mode)(GLFWmonitor *monitor)
{
	return (GLFWvidmode *)glfwGetVideoMode(monitor);
}
DEFINE_PRIM(_ABSTRACT(GLFWvidmode), get_video_mode, _ABSTRACT(GLFWmonitor));

HL_PRIM void HL_NAME(set_gamma)(GLFWmonitor *monitor, float gamma)
{
	glfwSetGamma(monitor, gamma);
}
DEFINE_PRIM(_VOID, set_gamma, _ABSTRACT(GLFWmonitor) _F32);

HL_PRIM GLFWgammaramp *HL_NAME(get_gamma_ramp)(GLFWmonitor *monitor)
{
	return (GLFWgammaramp *)glfwGetGammaRamp(monitor);
}
DEFINE_PRIM(_ABSTRACT(GLFWgammaramp), get_gamma_ramp, _ABSTRACT(GLFWmonitor));

HL_PRIM void HL_NAME(set_gamma_ramp)(GLFWmonitor *monitor, GLFWgammaramp *ramp)
{
	glfwSetGammaRamp(monitor, ramp);
}
DEFINE_PRIM(_VOID, set_gamma_ramp, _ABSTRACT(GLFWmonitor) _ABSTRACT(GLFWgammaramp));

HL_PRIM void HL_NAME(default_window_hints)(void)
{
	glfwDefaultWindowHints();
}
DEFINE_PRIM(_VOID, default_window_hints, _NO_ARG);

HL_PRIM void HL_NAME(window_hint)(int hint, int value)
{
	glfwWindowHint(hint, value);
}
DEFINE_PRIM(_VOID, window_hint, _I32 _I32);

HL_PRIM void HL_NAME(window_hint_string)(int hint, vbyte *value)
{
	glfwWindowHintString(hint, (const char *)value);
}
DEFINE_PRIM(_VOID, window_hint_string, _I32 _BYTES);

HL_PRIM GLFWwindow *HL_NAME(create_window)(int width, int height, vbyte *title, GLFWmonitor *monitor, GLFWwindow *share)
{
	return glfwCreateWindow(width, height, (const char *)title, monitor, share);
}
DEFINE_PRIM(_ABSTRACT(GLFWwindow), create_window, _I32 _I32 _BYTES _ABSTRACT(GLFWmonitor) _ABSTRACT(GLFWwindow));

HL_PRIM void HL_NAME(destroy_window)(GLFWwindow *window)
{
	glfwDestroyWindow(window);
}
DEFINE_PRIM(_VOID, destroy_window, _ABSTRACT(GLFWwindow));

HL_PRIM int HL_NAME(window_should_close)(GLFWwindow *window)
{
	return glfwWindowShouldClose(window);
}
DEFINE_PRIM(_I32, window_should_close, _ABSTRACT(GLFWwindow));

HL_PRIM void HL_NAME(set_window_should_close)(GLFWwindow *window, int value)
{
	glfwSetWindowShouldClose(window, value);
}
DEFINE_PRIM(_VOID, set_window_should_close, _ABSTRACT(GLFWwindow) _I32);

HL_PRIM vbyte *HL_NAME(get_window_title)(GLFWwindow *window)
{
	return (vbyte *)glfwGetWindowTitle(window);
}
DEFINE_PRIM(_BYTES, get_window_title, _ABSTRACT(GLFWwindow));

HL_PRIM void HL_NAME(set_window_title)(GLFWwindow *window, vbyte *title)
{
	glfwSetWindowTitle(window, (const char *)title);
}
DEFINE_PRIM(_VOID, set_window_title, _ABSTRACT(GLFWwindow) _BYTES);

HL_PRIM void HL_NAME(set_window_icon)(GLFWwindow *window, int count, GLFWimage *images)
{
	glfwSetWindowIcon(window, count, images);
}
DEFINE_PRIM(_VOID, set_window_icon, _ABSTRACT(GLFWwindow) _I32 _ABSTRACT(GLFWimage));

// TODO: REVIEW (glfwGetWindowPos):
//   - parameter 'xpos': pointer to primitive type: out-param o array
//   - parameter 'ypos': pointer to primitive type: out-param o array
HL_PRIM void HL_NAME(get_window_pos)(GLFWwindow *window, vbyte *xpos, vbyte *ypos)
{
	glfwGetWindowPos(window, (int *)xpos, (int *)ypos);
}
DEFINE_PRIM(_VOID, get_window_pos, _ABSTRACT(GLFWwindow) _BYTES _BYTES);

HL_PRIM void HL_NAME(set_window_pos)(GLFWwindow *window, int xpos, int ypos)
{
	glfwSetWindowPos(window, xpos, ypos);
}
DEFINE_PRIM(_VOID, set_window_pos, _ABSTRACT(GLFWwindow) _I32 _I32);

// TODO: REVIEW (glfwGetWindowSize):
//   - parameter 'width': pointer to primitive type: out-param o array
//   - parameter 'height': pointer to primitive type: out-param o array
HL_PRIM void HL_NAME(get_window_size)(GLFWwindow *window, vbyte *width, vbyte *height)
{
	glfwGetWindowSize(window, (int *)width, (int *)height);
}
DEFINE_PRIM(_VOID, get_window_size, _ABSTRACT(GLFWwindow) _BYTES _BYTES);

HL_PRIM void HL_NAME(set_window_size_limits)(GLFWwindow *window, int minwidth, int minheight, int maxwidth, int maxheight)
{
	glfwSetWindowSizeLimits(window, minwidth, minheight, maxwidth, maxheight);
}
DEFINE_PRIM(_VOID, set_window_size_limits, _ABSTRACT(GLFWwindow) _I32 _I32 _I32 _I32);

HL_PRIM void HL_NAME(set_window_aspect_ratio)(GLFWwindow *window, int numer, int denom)
{
	glfwSetWindowAspectRatio(window, numer, denom);
}
DEFINE_PRIM(_VOID, set_window_aspect_ratio, _ABSTRACT(GLFWwindow) _I32 _I32);

HL_PRIM void HL_NAME(set_window_size)(GLFWwindow *window, int width, int height)
{
	glfwSetWindowSize(window, width, height);
}
DEFINE_PRIM(_VOID, set_window_size, _ABSTRACT(GLFWwindow) _I32 _I32);

// TODO: REVIEW (glfwGetFramebufferSize):
//   - parameter 'width': pointer to primitive type: out-param o array
//   - parameter 'height': pointer to primitive type: out-param o array
HL_PRIM void HL_NAME(get_framebuffer_size)(GLFWwindow *window, vbyte *width, vbyte *height)
{
	glfwGetFramebufferSize(window, (int *)width, (int *)height);
}
DEFINE_PRIM(_VOID, get_framebuffer_size, _ABSTRACT(GLFWwindow) _BYTES _BYTES);

// TODO: REVIEW (glfwGetWindowFrameSize):
//   - parameter 'left': pointer to primitive type: out-param o array
//   - parameter 'top': pointer to primitive type: out-param o array
//   - parameter 'right': pointer to primitive type: out-param o array
//   - parameter 'bottom': pointer to primitive type: out-param o array
HL_PRIM void HL_NAME(get_window_frame_size)(GLFWwindow *window, vbyte *left, vbyte *top, vbyte *right, vbyte *bottom)
{
	glfwGetWindowFrameSize(window, (int *)left, (int *)top, (int *)right, (int *)bottom);
}
DEFINE_PRIM(_VOID, get_window_frame_size, _ABSTRACT(GLFWwindow) _BYTES _BYTES _BYTES _BYTES);

// TODO: REVIEW (glfwGetWindowContentScale):
//   - parameter 'xscale': pointer to primitive type: out-param o array
//   - parameter 'yscale': pointer to primitive type: out-param o array
HL_PRIM void HL_NAME(get_window_content_scale)(GLFWwindow *window, vbyte *xscale, vbyte *yscale)
{
	glfwGetWindowContentScale(window, (float *)xscale, (float *)yscale);
}
DEFINE_PRIM(_VOID, get_window_content_scale, _ABSTRACT(GLFWwindow) _BYTES _BYTES);

HL_PRIM float HL_NAME(get_window_opacity)(GLFWwindow *window)
{
	return glfwGetWindowOpacity(window);
}
DEFINE_PRIM(_F32, get_window_opacity, _ABSTRACT(GLFWwindow));

HL_PRIM void HL_NAME(set_window_opacity)(GLFWwindow *window, float opacity)
{
	glfwSetWindowOpacity(window, opacity);
}
DEFINE_PRIM(_VOID, set_window_opacity, _ABSTRACT(GLFWwindow) _F32);

HL_PRIM void HL_NAME(iconify_window)(GLFWwindow *window)
{
	glfwIconifyWindow(window);
}
DEFINE_PRIM(_VOID, iconify_window, _ABSTRACT(GLFWwindow));

HL_PRIM void HL_NAME(restore_window)(GLFWwindow *window)
{
	glfwRestoreWindow(window);
}
DEFINE_PRIM(_VOID, restore_window, _ABSTRACT(GLFWwindow));

HL_PRIM void HL_NAME(maximize_window)(GLFWwindow *window)
{
	glfwMaximizeWindow(window);
}
DEFINE_PRIM(_VOID, maximize_window, _ABSTRACT(GLFWwindow));

HL_PRIM void HL_NAME(show_window)(GLFWwindow *window)
{
	glfwShowWindow(window);
}
DEFINE_PRIM(_VOID, show_window, _ABSTRACT(GLFWwindow));

HL_PRIM void HL_NAME(hide_window)(GLFWwindow *window)
{
	glfwHideWindow(window);
}
DEFINE_PRIM(_VOID, hide_window, _ABSTRACT(GLFWwindow));

HL_PRIM void HL_NAME(focus_window)(GLFWwindow *window)
{
	glfwFocusWindow(window);
}
DEFINE_PRIM(_VOID, focus_window, _ABSTRACT(GLFWwindow));

HL_PRIM void HL_NAME(request_window_attention)(GLFWwindow *window)
{
	glfwRequestWindowAttention(window);
}
DEFINE_PRIM(_VOID, request_window_attention, _ABSTRACT(GLFWwindow));

HL_PRIM GLFWmonitor *HL_NAME(get_window_monitor)(GLFWwindow *window)
{
	return glfwGetWindowMonitor(window);
}
DEFINE_PRIM(_ABSTRACT(GLFWmonitor), get_window_monitor, _ABSTRACT(GLFWwindow));

HL_PRIM void HL_NAME(set_window_monitor)(GLFWwindow *window, GLFWmonitor *monitor, int xpos, int ypos, int width, int height, int refreshRate)
{
	glfwSetWindowMonitor(window, monitor, xpos, ypos, width, height, refreshRate);
}
DEFINE_PRIM(_VOID, set_window_monitor, _ABSTRACT(GLFWwindow) _ABSTRACT(GLFWmonitor) _I32 _I32 _I32 _I32 _I32);

HL_PRIM int HL_NAME(get_window_attrib)(GLFWwindow *window, int attrib)
{
	return glfwGetWindowAttrib(window, attrib);
}
DEFINE_PRIM(_I32, get_window_attrib, _ABSTRACT(GLFWwindow) _I32);

HL_PRIM void HL_NAME(set_window_attrib)(GLFWwindow *window, int attrib, int value)
{
	glfwSetWindowAttrib(window, attrib, value);
}
DEFINE_PRIM(_VOID, set_window_attrib, _ABSTRACT(GLFWwindow) _I32 _I32);

// TODO: REVIEW (glfwSetWindowUserPointer):
//   - parameter 'pointer': pointer to primitive type: out-param o array
HL_PRIM void HL_NAME(set_window_user_pointer)(GLFWwindow *window, vbyte *pointer)
{
	glfwSetWindowUserPointer(window, (void *)pointer);
}
DEFINE_PRIM(_VOID, set_window_user_pointer, _ABSTRACT(GLFWwindow) _BYTES);

// TODO: REVIEW (glfwGetWindowUserPointer):
//   - return: pointer to primitive type: out-param o array
HL_PRIM vbyte *HL_NAME(get_window_user_pointer)(GLFWwindow *window)
{
	return (vbyte *)glfwGetWindowUserPointer(window);
}
DEFINE_PRIM(_BYTES, get_window_user_pointer, _ABSTRACT(GLFWwindow));

static vclosure *g_win_pos_cb = NULL;

static void native_window_pos_callback(GLFWwindow *window, int xpos, int ypos)
{
	if (g_win_pos_cb == NULL)
		return;
	vdynamic arg_x = {&hlt_i32, {.i = xpos}};
	vdynamic arg_y = {&hlt_i32, {.i = ypos}};
	vdynamic *args[2] = {&arg_x, &arg_y};
	glfw_call_haxe(g_win_pos_cb, args, 2);
}

HL_PRIM void HL_NAME(set_window_pos_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_win_pos_cb != NULL)
		hl_remove_root((void **)&g_win_pos_cb);
	g_win_pos_cb = callback;
	if (g_win_pos_cb != NULL)
	{
		hl_add_root((void **)&g_win_pos_cb);
		glfwSetWindowPosCallback(window, native_window_pos_callback);
	}
	else
	{
		glfwSetWindowPosCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_window_pos_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _I32 _I32));

static vclosure *g_win_size_cb = NULL;

static void native_window_size_callback(GLFWwindow *window, int width, int height)
{
	if (g_win_size_cb == NULL)
		return;
	vdynamic arg_w = {&hlt_i32, {.i = width}};
	vdynamic arg_h = {&hlt_i32, {.i = height}};
	vdynamic *args[2] = {&arg_w, &arg_h};
	glfw_call_haxe(g_win_size_cb, args, 2);
}

HL_PRIM void HL_NAME(set_window_size_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_win_size_cb != NULL)
		hl_remove_root((void **)&g_win_size_cb);
	g_win_size_cb = callback;
	if (g_win_size_cb != NULL)
	{
		hl_add_root((void **)&g_win_size_cb);
		glfwSetWindowSizeCallback(window, native_window_size_callback);
	}
	else
	{
		glfwSetWindowSizeCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_window_size_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _I32 _I32));

static vclosure *g_win_close_cb = NULL;

static void native_window_close_callback(GLFWwindow *window)
{
	if (g_win_close_cb == NULL)
		return;
	glfw_call_haxe(g_win_close_cb, NULL, 0);
}

HL_PRIM void HL_NAME(set_window_close_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_win_close_cb != NULL)
		hl_remove_root((void **)&g_win_close_cb);
	g_win_close_cb = callback;
	if (g_win_close_cb != NULL)
	{
		hl_add_root((void **)&g_win_close_cb);
		glfwSetWindowCloseCallback(window, native_window_close_callback);
	}
	else
	{
		glfwSetWindowCloseCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_window_close_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _NO_ARG));

static vclosure *g_win_refresh_cb = NULL;

static void native_window_refresh_callback(GLFWwindow *window)
{
	if (g_win_refresh_cb == NULL)
		return;
	glfw_call_haxe(g_win_refresh_cb, NULL, 0);
}

HL_PRIM void HL_NAME(set_window_refresh_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_win_refresh_cb != NULL)
		hl_remove_root((void **)&g_win_refresh_cb);
	g_win_refresh_cb = callback;
	if (g_win_refresh_cb != NULL)
	{
		hl_add_root((void **)&g_win_refresh_cb);
		glfwSetWindowRefreshCallback(window, native_window_refresh_callback);
	}
	else
	{
		glfwSetWindowRefreshCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_window_refresh_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _NO_ARG));

static vclosure *g_win_focus_cb = NULL;

static void native_window_focus_callback(GLFWwindow *window, int focused)
{
	if (g_win_focus_cb == NULL)
		return;
	vdynamic arg_f = {&hlt_bool, {.b = focused != 0}};
	vdynamic *args[1] = {&arg_f};
	glfw_call_haxe(g_win_focus_cb, args, 1);
}

HL_PRIM void HL_NAME(set_window_focus_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_win_focus_cb != NULL)
		hl_remove_root((void **)&g_win_focus_cb);
	g_win_focus_cb = callback;
	if (g_win_focus_cb != NULL)
	{
		hl_add_root((void **)&g_win_focus_cb);
		glfwSetWindowFocusCallback(window, native_window_focus_callback);
	}
	else
	{
		glfwSetWindowFocusCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_window_focus_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _BOOL));

static vclosure *g_win_iconify_cb = NULL;

static void native_window_iconify_callback(GLFWwindow *window, int iconified)
{
	if (g_win_iconify_cb == NULL)
		return;
	vdynamic arg_i = {&hlt_bool, {.b = iconified != 0}};
	vdynamic *args[1] = {&arg_i};
	glfw_call_haxe(g_win_iconify_cb, args, 1);
}

HL_PRIM void HL_NAME(set_window_iconify_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_win_iconify_cb != NULL)
		hl_remove_root((void **)&g_win_iconify_cb);
	g_win_iconify_cb = callback;
	if (g_win_iconify_cb != NULL)
	{
		hl_add_root((void **)&g_win_iconify_cb);
		glfwSetWindowIconifyCallback(window, native_window_iconify_callback);
	}
	else
	{
		glfwSetWindowIconifyCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_window_iconify_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _BOOL));

static vclosure *g_win_maximize_cb = NULL;

static void native_window_maximize_callback(GLFWwindow *window, int maximized)
{
	if (g_win_maximize_cb == NULL)
		return;
	vdynamic arg_m = {&hlt_bool, {.b = maximized != 0}};
	vdynamic *args[1] = {&arg_m};
	glfw_call_haxe(g_win_maximize_cb, args, 1);
}

HL_PRIM void HL_NAME(set_window_maximize_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_win_maximize_cb != NULL)
		hl_remove_root((void **)&g_win_maximize_cb);
	g_win_maximize_cb = callback;
	if (g_win_maximize_cb != NULL)
	{
		hl_add_root((void **)&g_win_maximize_cb);
		glfwSetWindowMaximizeCallback(window, native_window_maximize_callback);
	}
	else
	{
		glfwSetWindowMaximizeCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_window_maximize_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _BOOL));

static vclosure *g_framebuffer_size_cb = NULL;

static void native_framebuffer_size_callback(GLFWwindow *window, int width, int height)
{
	if (g_framebuffer_size_cb == NULL)
		return;
	vdynamic arg_w = {&hlt_i32, {.i = width}};
	vdynamic arg_h = {&hlt_i32, {.i = height}};
	vdynamic *args[2] = {&arg_w, &arg_h};
	glfw_call_haxe(g_framebuffer_size_cb, args, 2);
}

HL_PRIM void HL_NAME(set_framebuffer_size_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_framebuffer_size_cb != NULL)
		hl_remove_root((void **)&g_framebuffer_size_cb);
	g_framebuffer_size_cb = callback;
	if (g_framebuffer_size_cb != NULL)
	{
		hl_add_root((void **)&g_framebuffer_size_cb);
		glfwSetFramebufferSizeCallback(window, native_framebuffer_size_callback);
	}
	else
	{
		glfwSetFramebufferSizeCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_framebuffer_size_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _I32 _I32));

static vclosure *g_win_scale_cb = NULL;

static void native_window_content_scale_callback(GLFWwindow *window, float xscale, float yscale)
{
	if (g_win_scale_cb == NULL)
		return;
	vdynamic arg_x = {&hlt_f32, {.f = xscale}};
	vdynamic arg_y = {&hlt_f32, {.f = yscale}};
	vdynamic *args[2] = {&arg_x, &arg_y};
	glfw_call_haxe(g_win_scale_cb, args, 2);
}

HL_PRIM void HL_NAME(set_window_content_scale_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_win_scale_cb != NULL)
		hl_remove_root((void **)&g_win_scale_cb);
	g_win_scale_cb = callback;
	if (g_win_scale_cb != NULL)
	{
		hl_add_root((void **)&g_win_scale_cb);
		glfwSetWindowContentScaleCallback(window, native_window_content_scale_callback);
	}
	else
	{
		glfwSetWindowContentScaleCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_window_content_scale_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _F32 _F32));

HL_PRIM void HL_NAME(poll_events)(void)
{
	glfwPollEvents();
}
DEFINE_PRIM(_VOID, poll_events, _NO_ARG);

HL_PRIM void HL_NAME(wait_events)(void)
{
	glfwWaitEvents();
}
DEFINE_PRIM(_VOID, wait_events, _NO_ARG);

HL_PRIM void HL_NAME(wait_events_timeout)(double timeout)
{
	glfwWaitEventsTimeout(timeout);
}
DEFINE_PRIM(_VOID, wait_events_timeout, _F64);

HL_PRIM void HL_NAME(post_empty_event)(void)
{
	glfwPostEmptyEvent();
}
DEFINE_PRIM(_VOID, post_empty_event, _NO_ARG);

HL_PRIM int HL_NAME(get_input_mode)(GLFWwindow *window, int mode)
{
	return glfwGetInputMode(window, mode);
}
DEFINE_PRIM(_I32, get_input_mode, _ABSTRACT(GLFWwindow) _I32);

HL_PRIM void HL_NAME(set_input_mode)(GLFWwindow *window, int mode, int value)
{
	glfwSetInputMode(window, mode, value);
}
DEFINE_PRIM(_VOID, set_input_mode, _ABSTRACT(GLFWwindow) _I32 _I32);

HL_PRIM int HL_NAME(raw_mouse_motion_supported)(void)
{
	return glfwRawMouseMotionSupported();
}
DEFINE_PRIM(_I32, raw_mouse_motion_supported, _NO_ARG);

HL_PRIM vbyte *HL_NAME(get_key_name)(int key, int scancode)
{
	return (vbyte *)glfwGetKeyName(key, scancode);
}
DEFINE_PRIM(_BYTES, get_key_name, _I32 _I32);

HL_PRIM int HL_NAME(get_key_scancode)(int key)
{
	return glfwGetKeyScancode(key);
}
DEFINE_PRIM(_I32, get_key_scancode, _I32);

HL_PRIM int HL_NAME(get_key)(GLFWwindow *window, int key)
{
	return glfwGetKey(window, key);
}
DEFINE_PRIM(_I32, get_key, _ABSTRACT(GLFWwindow) _I32);

HL_PRIM int HL_NAME(get_mouse_button)(GLFWwindow *window, int button)
{
	return glfwGetMouseButton(window, button);
}
DEFINE_PRIM(_I32, get_mouse_button, _ABSTRACT(GLFWwindow) _I32);

// TODO: REVIEW (glfwGetCursorPos):
//   - parameter 'xpos': pointer to primitive type: out-param o array
//   - parameter 'ypos': pointer to primitive type: out-param o array
HL_PRIM void HL_NAME(get_cursor_pos)(GLFWwindow *window, vbyte *xpos, vbyte *ypos)
{
	glfwGetCursorPos(window, (double *)xpos, (double *)ypos);
}
DEFINE_PRIM(_VOID, get_cursor_pos, _ABSTRACT(GLFWwindow) _BYTES _BYTES);

HL_PRIM void HL_NAME(set_cursor_pos)(GLFWwindow *window, double xpos, double ypos)
{
	glfwSetCursorPos(window, xpos, ypos);
}
DEFINE_PRIM(_VOID, set_cursor_pos, _ABSTRACT(GLFWwindow) _F64 _F64);

HL_PRIM GLFWcursor *HL_NAME(create_cursor)(GLFWimage *image, int xhot, int yhot)
{
	return glfwCreateCursor(image, xhot, yhot);
}
DEFINE_PRIM(_ABSTRACT(GLFWcursor), create_cursor, _ABSTRACT(GLFWimage) _I32 _I32);

HL_PRIM GLFWcursor *HL_NAME(create_standard_cursor)(int shape)
{
	return glfwCreateStandardCursor(shape);
}
DEFINE_PRIM(_ABSTRACT(GLFWcursor), create_standard_cursor, _I32);

HL_PRIM void HL_NAME(destroy_cursor)(GLFWcursor *cursor)
{
	glfwDestroyCursor(cursor);
}
DEFINE_PRIM(_VOID, destroy_cursor, _ABSTRACT(GLFWcursor));

HL_PRIM void HL_NAME(set_cursor)(GLFWwindow *window, GLFWcursor *cursor)
{
	glfwSetCursor(window, cursor);
}
DEFINE_PRIM(_VOID, set_cursor, _ABSTRACT(GLFWwindow) _ABSTRACT(GLFWcursor));

static vclosure *g_key_cb = NULL;
static void native_key_callback(GLFWwindow *window, int key, int scancode, int action, int mods)
{
	if (g_key_cb == NULL)
		return;
	vdynamic arg0 = {&hlt_i32, {.i = key}};
	vdynamic arg1 = {&hlt_i32, {.i = scancode}};
	vdynamic arg2 = {&hlt_i32, {.i = action}};
	vdynamic arg3 = {&hlt_i32, {.i = mods}};
	vdynamic *args[4] = {&arg0, &arg1, &arg2, &arg3};
	glfw_call_haxe(g_key_cb, args, 4);
}

static vclosure *g_char_cb = NULL;
static void native_char_callback(GLFWwindow *window, unsigned int codepoint)
{
	if (g_char_cb == NULL)
		return;
	vdynamic arg0 = {&hlt_i32, {.i = (int)codepoint}};
	vdynamic *args[1] = {&arg0};
	glfw_call_haxe(g_char_cb, args, 1);
}

static vclosure *g_char_mods_cb = NULL;
static void native_char_mods_callback(GLFWwindow *window, unsigned int codepoint, int mods)
{
	if (g_char_mods_cb == NULL)
		return;
	vdynamic arg0 = {&hlt_i32, {.i = (int)codepoint}};
	vdynamic arg1 = {&hlt_i32, {.i = mods}};
	vdynamic *args[2] = {&arg0, &arg1};
	glfw_call_haxe(g_char_mods_cb, args, 2);
}

static vclosure *g_mouse_button_cb = NULL;
static void native_mouse_button_callback(GLFWwindow *window, int button, int action, int mods)
{
	if (g_mouse_button_cb == NULL)
		return;
	vdynamic arg0 = {&hlt_i32, {.i = button}};
	vdynamic arg1 = {&hlt_i32, {.i = action}};
	vdynamic arg2 = {&hlt_i32, {.i = mods}};
	vdynamic *args[3] = {&arg0, &arg1, &arg2};
	glfw_call_haxe(g_mouse_button_cb, args, 3);
}

static vclosure *g_cursor_pos_cb = NULL;
static void native_cursor_pos_callback(GLFWwindow *window, double xpos, double ypos)
{
	if (g_cursor_pos_cb == NULL)
		return;
	vdynamic arg0 = {&hlt_f64, {.d = xpos}};
	vdynamic arg1 = {&hlt_f64, {.d = ypos}};
	vdynamic *args[2] = {&arg0, &arg1};
	glfw_call_haxe(g_cursor_pos_cb, args, 2);
}

static vclosure *g_cursor_enter_cb = NULL;
static void native_cursor_enter_callback(GLFWwindow *window, int entered)
{
	if (g_cursor_enter_cb == NULL)
		return;
	vdynamic arg0 = {&hlt_i32, {.i = entered}};
	vdynamic *args[1] = {&arg0};
	glfw_call_haxe(g_cursor_enter_cb, args, 1);
}

static vclosure *g_scroll_cb = NULL;
static void native_scroll_callback(GLFWwindow *window, double xoffset, double yoffset)
{
	if (g_scroll_cb == NULL)
		return;
	vdynamic arg0 = {&hlt_f64, {.d = xoffset}};
	vdynamic arg1 = {&hlt_f64, {.d = yoffset}};
	vdynamic *args[2] = {&arg0, &arg1};
	glfw_call_haxe(g_scroll_cb, args, 2);
}

static vclosure *g_drop_cb = NULL;
static void native_drop_callback(GLFWwindow *window, int count, const char **paths)
{
	if (g_drop_cb == NULL)
		return;
	varray *arr = hl_alloc_array(&hlt_bytes, count);
	vbyte **ptrs = hl_aptr(arr, vbyte *);
	for (int i = 0; i < count; i++)
	{
		ptrs[i] = hl_copy_bytes((vbyte *)paths[i], (int)strlen(paths[i]) + 1);
	}
	vdynamic arg0 = {&hlt_i32, {.i = count}};
	vdynamic arg1 = {&hlt_array, {.ptr = arr}};
	vdynamic *args[2] = {&arg0, &arg1};
	glfw_call_haxe(g_drop_cb, args, 2);
}

HL_PRIM void HL_NAME(set_key_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_key_cb != NULL)
		hl_remove_root((void **)&g_key_cb);
	g_key_cb = callback;
	if (g_key_cb != NULL)
	{
		hl_add_root((void **)&g_key_cb);
		glfwSetKeyCallback(window, native_key_callback);
	}
	else
	{
		glfwSetKeyCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_key_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _I32 _I32 _I32 _I32));

HL_PRIM void HL_NAME(set_char_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_char_cb != NULL)
		hl_remove_root((void **)&g_char_cb);
	g_char_cb = callback;
	if (g_char_cb != NULL)
	{
		hl_add_root((void **)&g_char_cb);
		glfwSetCharCallback(window, native_char_callback);
	}
	else
	{
		glfwSetCharCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_char_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _I32));

HL_PRIM void HL_NAME(set_char_mods_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_char_mods_cb != NULL)
		hl_remove_root((void **)&g_char_mods_cb);
	g_char_mods_cb = callback;
	if (g_char_mods_cb != NULL)
	{
		hl_add_root((void **)&g_char_mods_cb);
		glfwSetCharModsCallback(window, native_char_mods_callback);
	}
	else
	{
		glfwSetCharModsCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_char_mods_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _I32 _I32));

HL_PRIM void HL_NAME(set_mouse_button_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_mouse_button_cb != NULL)
		hl_remove_root((void **)&g_mouse_button_cb);
	g_mouse_button_cb = callback;
	if (g_mouse_button_cb != NULL)
	{
		hl_add_root((void **)&g_mouse_button_cb);
		glfwSetMouseButtonCallback(window, native_mouse_button_callback);
	}
	else
	{
		glfwSetMouseButtonCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_mouse_button_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _I32 _I32 _I32));

HL_PRIM void HL_NAME(set_cursor_pos_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_cursor_pos_cb != NULL)
		hl_remove_root((void **)&g_cursor_pos_cb);
	g_cursor_pos_cb = callback;
	if (g_cursor_pos_cb != NULL)
	{
		hl_add_root((void **)&g_cursor_pos_cb);
		glfwSetCursorPosCallback(window, native_cursor_pos_callback);
	}
	else
	{
		glfwSetCursorPosCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_cursor_pos_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _F64 _F64));

HL_PRIM void HL_NAME(set_cursor_enter_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_cursor_enter_cb != NULL)
		hl_remove_root((void **)&g_cursor_enter_cb);
	g_cursor_enter_cb = callback;
	if (g_cursor_enter_cb != NULL)
	{
		hl_add_root((void **)&g_cursor_enter_cb);
		glfwSetCursorEnterCallback(window, native_cursor_enter_callback);
	}
	else
	{
		glfwSetCursorEnterCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_cursor_enter_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _I32));

HL_PRIM void HL_NAME(set_scroll_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_scroll_cb != NULL)
		hl_remove_root((void **)&g_scroll_cb);
	g_scroll_cb = callback;
	if (g_scroll_cb != NULL)
	{
		hl_add_root((void **)&g_scroll_cb);
		glfwSetScrollCallback(window, native_scroll_callback);
	}
	else
	{
		glfwSetScrollCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_scroll_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _F64 _F64));

HL_PRIM void HL_NAME(set_drop_callback)(GLFWwindow *window, vclosure *callback)
{
	if (g_drop_cb != NULL)
		hl_remove_root((void **)&g_drop_cb);
	g_drop_cb = callback;
	if (g_drop_cb != NULL)
	{
		hl_add_root((void **)&g_drop_cb);
		glfwSetDropCallback(window, native_drop_callback);
	}
	else
	{
		glfwSetDropCallback(window, NULL);
	}
}
DEFINE_PRIM(_VOID, set_drop_callback, _ABSTRACT(GLFWwindow) _FUN(_VOID, _I32 _ARR));

HL_PRIM int HL_NAME(joystick_present)(int jid)
{
	return glfwJoystickPresent(jid);
}
DEFINE_PRIM(_I32, joystick_present, _I32);

// TODO: REVIEW (glfwGetJoystickAxes):
//   - return: pointer to primitive type: out-param o array
//   - parameter 'count': pointer to primitive type: out-param o array
HL_PRIM vbyte *HL_NAME(get_joystick_axes)(int jid, vbyte *count)
{
	return (vbyte *)glfwGetJoystickAxes(jid, (int *)count);
}
DEFINE_PRIM(_BYTES, get_joystick_axes, _I32 _BYTES);

// TODO: REVIEW (glfwGetJoystickButtons):
//   - parameter 'count': pointer to primitive type: out-param o array
HL_PRIM vbyte *HL_NAME(get_joystick_buttons)(int jid, vbyte *count)
{
	return (vbyte *)glfwGetJoystickButtons(jid, (int *)count);
}
DEFINE_PRIM(_BYTES, get_joystick_buttons, _I32 _BYTES);

// TODO: REVIEW (glfwGetJoystickHats):
//   - parameter 'count': pointer to primitive type: out-param o array
HL_PRIM vbyte *HL_NAME(get_joystick_hats)(int jid, vbyte *count)
{
	return (vbyte *)glfwGetJoystickHats(jid, (int *)count);
}
DEFINE_PRIM(_BYTES, get_joystick_hats, _I32 _BYTES);

HL_PRIM vbyte *HL_NAME(get_joystick_name)(int jid)
{
	return (vbyte *)glfwGetJoystickName(jid);
}
DEFINE_PRIM(_BYTES, get_joystick_name, _I32);

HL_PRIM vbyte *HL_NAME(get_joystick_guid)(int jid)
{
	return (vbyte *)glfwGetJoystickGUID(jid);
}
DEFINE_PRIM(_BYTES, get_joystick_guid, _I32);

// TODO: REVIEW (glfwSetJoystickUserPointer):
//   - parameter 'pointer': pointer to primitive type: out-param o array
HL_PRIM void HL_NAME(set_joystick_user_pointer)(int jid, vbyte *pointer)
{
	glfwSetJoystickUserPointer(jid, (void *)pointer);
}
DEFINE_PRIM(_VOID, set_joystick_user_pointer, _I32 _BYTES);

// TODO: REVIEW (glfwGetJoystickUserPointer):
//   - return: pointer to primitive type: out-param o array
HL_PRIM vbyte *HL_NAME(get_joystick_user_pointer)(int jid)
{
	return (vbyte *)glfwGetJoystickUserPointer(jid);
}
DEFINE_PRIM(_BYTES, get_joystick_user_pointer, _I32);

HL_PRIM int HL_NAME(joystick_is_gamepad)(int jid)
{
	return glfwJoystickIsGamepad(jid);
}
DEFINE_PRIM(_I32, joystick_is_gamepad, _I32);

// TODO: REVIEW (glfwSetJoystickCallback):
//   - return: callback (function pointer): necesita puente manual
//   - parameter 'callback': callback (function pointer): necesita puente manual
HL_PRIM vbyte *HL_NAME(set_joystick_callback)(vbyte *callback)
{
	return (vbyte *)glfwSetJoystickCallback((void (*)(int, int))callback);
}
DEFINE_PRIM(_BYTES, set_joystick_callback, _BYTES);

HL_PRIM int HL_NAME(update_gamepad_mappings)(vbyte *string)
{
	return glfwUpdateGamepadMappings((const char *)string);
}
DEFINE_PRIM(_I32, update_gamepad_mappings, _BYTES);

HL_PRIM vbyte *HL_NAME(get_gamepad_name)(int jid)
{
	return (vbyte *)glfwGetGamepadName(jid);
}
DEFINE_PRIM(_BYTES, get_gamepad_name, _I32);

HL_PRIM int HL_NAME(get_gamepad_state)(int jid, GLFWgamepadstate *state)
{
	return glfwGetGamepadState(jid, state);
}
DEFINE_PRIM(_I32, get_gamepad_state, _I32 _ABSTRACT(GLFWgamepadstate));

HL_PRIM void HL_NAME(set_clipboard_string)(GLFWwindow *window, vbyte *string)
{
	glfwSetClipboardString(window, (const char *)string);
}
DEFINE_PRIM(_VOID, set_clipboard_string, _ABSTRACT(GLFWwindow) _BYTES);

HL_PRIM vbyte *HL_NAME(get_clipboard_string)(GLFWwindow *window)
{
	return (vbyte *)glfwGetClipboardString(window);
}
DEFINE_PRIM(_BYTES, get_clipboard_string, _ABSTRACT(GLFWwindow));

HL_PRIM double HL_NAME(get_time)(void)
{
	return glfwGetTime();
}
DEFINE_PRIM(_F64, get_time, _NO_ARG);

HL_PRIM void HL_NAME(set_time)(double time)
{
	glfwSetTime(time);
}
DEFINE_PRIM(_VOID, set_time, _F64);

HL_PRIM unsigned long long HL_NAME(get_timer_value)(void)
{
	return glfwGetTimerValue();
}
DEFINE_PRIM(_I64, get_timer_value, _NO_ARG);

HL_PRIM unsigned long long HL_NAME(get_timer_frequency)(void)
{
	return glfwGetTimerFrequency();
}
DEFINE_PRIM(_I64, get_timer_frequency, _NO_ARG);

HL_PRIM void HL_NAME(make_context_current)(GLFWwindow *window)
{
	glfwMakeContextCurrent(window);
}
DEFINE_PRIM(_VOID, make_context_current, _ABSTRACT(GLFWwindow));

HL_PRIM GLFWwindow *HL_NAME(get_current_context)(void)
{
	return glfwGetCurrentContext();
}
DEFINE_PRIM(_ABSTRACT(GLFWwindow), get_current_context, _NO_ARG);

HL_PRIM void HL_NAME(swap_buffers)(GLFWwindow *window)
{
	glfwSwapBuffers(window);
}
DEFINE_PRIM(_VOID, swap_buffers, _ABSTRACT(GLFWwindow));

HL_PRIM void HL_NAME(swap_interval)(int interval)
{
	glfwSwapInterval(interval);
}
DEFINE_PRIM(_VOID, swap_interval, _I32);

HL_PRIM int HL_NAME(extension_supported)(vbyte *extension)
{
	return glfwExtensionSupported((const char *)extension);
}
DEFINE_PRIM(_I32, extension_supported, _BYTES);

HL_PRIM vbyte *HL_NAME(get_proc_address_fn)() {
    return (vbyte *)(void *)&glfwGetProcAddress;
}
DEFINE_PRIM(_BYTES, get_proc_address_fn, _NO_ARG);

HL_PRIM int HL_NAME(vulkan_supported)(void)
{
	return glfwVulkanSupported();
}
DEFINE_PRIM(_I32, vulkan_supported, _NO_ARG);

// TODO: REVIEW (glfwGetRequiredInstanceExtensions):
//   - return: double pointer: verify use
//   - parameter 'count': pointer to primitive type: out-param o array
HL_PRIM vbyte *HL_NAME(get_required_instance_extensions)(vbyte *count)
{
	return (vbyte *)glfwGetRequiredInstanceExtensions((unsigned int *)count);
}
DEFINE_PRIM(_BYTES, get_required_instance_extensions, _BYTES);

require("git"):setup()

Status:children_add(function()
    local h = cx.active.current.hovered
    if h == nil or ya.target_family() ~= "unix" then
        return ui.Line {}
    end

    return ui.Line {
        ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("#209fb5"),
        ui.Span(":"),
        ui.Span(ya.user_name(h.cha.gid) or tostring(h.cha.gid)):fg("#209fb5"),
        ui.Span(" "),
    }
end, 500, Status.RIGHT)

Header:children_add(function()
    if ya.target_family() ~= "unix" then
        return ui.Line {}
    end

    return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. " "):fg("#dd7878")
end, 500, Header.LEFT)

-- ─── moniteurs ──────────────────────────────────────────────────────────

hl.monitor({
  output   = "DP-1",           -- port de sortie
  mode     = "3840x2560@120",  -- résolution native + taux de rafraîchissement
  position = "auto",           -- position auto-détectée
  scale    = "2",              -- mise à l'échelle HiDPI
})

-- composition
hl.config({
    render = {
        direct_scanout = true,
    },
})

-- vrr
hl.config({
    misc = {
        vrr = 2,
    },
})

-- tearing
hl.config({
    general = {
        allow_tearing = true,
    },
})

-- ─── applications ────────────────────────────────────────────────────────

local terminal    = "ghostty"                         -- terminal par défaut
local fileManager = "nautilus"                        -- gestionnaire de fichiers
local menu        = "hyprlauncher"                    -- lanceur d'applications
local browser     = "flatpak run com.brave.Browser"   -- navigateur internet

-- ─── démarrage automatique ──────────────────────────────────────────────

hl.on("hyprland.start", function ()
  hl.exec_cmd("hyprpaper")        -- fond d'écran
  hl.exec_cmd("waybar")           -- barre d'état
  hl.exec_cmd("hypridle")         -- gestion de l'inactivité / verrouillage
  hl.exec_cmd("hyprpolkitagent")  -- agent d'authentification polkit
end)

-- ─── variables d'environnement ──────────────────────────────────────────

hl.env("XCURSOR_SIZE", "24")      -- taille du curseur (X11 / XWayland)
hl.env("HYPRCURSOR_SIZE", "24")   -- taille du curseur (protocole Hyprcursor)

-- ─── permissions ────────────────────────────────────────────────────────

-- les changements de permissions nécessitent un redémarrage de Hyprland
-- et ne sont pas appliqués à chaud, pour des raisons de sécurité

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,   -- exige une autorisation explicite par binaire
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")                            -- capture d'écran
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow") -- portail de capture
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")                              -- gestionnaire de plugins

-- ─── apparence ──────────────────────────────────────────────────────────

hl.config({
  general = {
    gaps_in  = 20,   -- espace entre les fenêtres
    gaps_out = 40,   -- espace entre les fenêtres et les bords d'écran
    border_size = 1, -- épaisseur des bordures

    col = {
      active_border   = { colors = {"rgba(cba6f7ee)", "rgba(89b4faee)"}, angle = 45 },  -- dégradé bordure active (Catppuccin)
      inactive_border = "rgba(45475aaa)",                                               -- couleur bordure inactive
    },

    resize_on_border = true,  -- permet de redimensionner en tirant les bordures
    allow_tearing = false,    -- désactive le tearing (déchirement d'image)
    layout = "dwindle",       -- disposition des fenêtres (dwindle)
  },

  decoration = {
    rounding       = 0,  -- rayon des coins arrondis
    rounding_power = 2,  -- courbe de l'arrondi

    active_opacity   = 1.0, -- opacité de la fenêtre active
    inactive_opacity = 1.0, -- opacité des fenêtres inactives

    shadow = {
      enabled      = true,        -- active les ombres portées
      range        = 4,           -- portée de l'ombre
      render_power = 3,           -- qualité de rendu de l'ombre
      color        = 0xee11111b,  -- couleur de l'ombre
    },

    blur = {
      enabled   = true,   -- active le flou
      size      = 3,      -- taille du flou
      passes    = 1,      -- nombre de passes de flou
      vibrancy  = 0.1696, -- intensité des couleurs sous le flou
    },
  },

  animations = {
    enabled = true, -- active les animations
  },
})

-- courbes et animations par défaut
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })  -- démarre vite, ralentit en douceur
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })  -- accélère puis décélère
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })  -- vitesse constante
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })  -- quasi linéaire
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })  -- transition rapide

-- ressorts par défaut
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })  -- effet ressort (fenêtres)

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })                             -- vitesse globale par défaut
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })                        -- animation des bordures
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })                                -- déplacement/redim. des fenêtres
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })   -- apparition des fenêtres
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })   -- disparition des fenêtres
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })                        -- fondu d'entrée
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })                        -- fondu de sortie
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })                               -- fondu générique
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })                        -- animation des layers (overlays, barres)
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })        -- apparition des layers
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })        -- disparition des layers
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })                        -- fondu d'entrée des layers
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })                        -- fondu de sortie des layers
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })        -- transition entre espaces de travail
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })        -- entrée sur un espace de travail
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })        -- sortie d'un espace de travail
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })                               -- animation du zoom

hl.config({
  dwindle = {
    preserve_split = true,  -- conserve la disposition du split lors des changements
  },
})

hl.config({
  master = {
    new_status = "master", -- une nouvelle fenêtre devient la fenêtre maître
  },
})

hl.config({
  scrolling = {
    fullscreen_on_one_column = true, -- plein écran auto s'il ne reste qu'une colonne
  },
})

-- ─── divers ─────────────────────────────────────────────────────────────

hl.config({
  misc = {
    force_default_wallpaper  = -1,     -- mettre 0 ou 1 pour désactiver les fonds d'écran par défaut
    disable_hyprland_logo    = false,  -- si true, désactive le logo Hyprland / fond d'écran par défaut
    disable_splash_rendering = true,   -- désactive le texte de démarrage affiché au lancement
  },
})

-- ─── entrées ────────────────────────────────────────────────────────────

hl.config({
  input = {
    kb_layout  = "fr",  -- disposition clavier français
    kb_variant = "mac", -- variante clavier Mac
    kb_model   = "",    -- modèle clavier (vide = auto)
    kb_options = "",    -- options clavier additionnelles (X11)
    kb_rules   = "",    -- règles clavier (X11)
    follow_mouse = 1,   -- le focus suit la souris
    sensitivity = 0,    -- de -1.0 à 1.0, 0 = aucune modification

    touchpad = {
      natural_scroll = false, -- défilement naturel désactivé
    },
  },
})

hl.gesture({
  fingers = 3,              -- nombre de doigts requis
  direction = "horizontal", -- sens du geste
  action = "workspace"      -- change d'espace de travail
})

-- configuration par périphérique (exemple)
hl.device({
  name        = "logitech-g703-ls-1", -- identifiant du périphérique
  sensitivity = -0.8,                 -- sensibilité réduite pour cette souris
})

-- ─── raccourcis clavier ─────────────────────────────────────────────────

local mainMod = "SUPER" -- touche "Windows" définie comme modificateur principal

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))                                        -- ouvrir un terminal
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())                         -- fermer la fenêtre active
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))   -- éteindre / quitter Hyprland
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))                                          -- ouvrir le gestionnaire de fichiers
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))                            -- basculer le mode flottant
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))                                             -- ouvrir le lanceur d'applications
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())                                                -- activer le mode pseudo (dwindle)
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))                                          -- basculer l'orientation du split
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))                                           -- verrouiller l'écran
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))                                              -- ouvrir le navigateur internet

-- déplacer le focus avec mainMod + flèches
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))   -- focus fenêtre à gauche
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))  -- focus fenêtre à droite
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))     -- focus fenêtre au-dessus
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))   -- focus fenêtre en-dessous

-- déplacer la fenêtre avec mainMod + SHIFT + flèches
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))   -- déplacer fenêtre à gauche
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))  -- déplacer fenêtre à droite
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))     -- déplacer fenêtre au-dessus
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))   -- déplacer fenêtre en-dessous

-- déplacer la fenêtre active vers un espace avec mainMod + SHIFT + [0-9]
local workspaceKeycodes = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }  -- codes physiques des touches 1 à 0

for i, code in ipairs(workspaceKeycodes) do
  hl.bind(mainMod .. " + code:" .. code,         hl.dsp.focus({ workspace = i }))        -- aller à l'espace i
  hl.bind(mainMod .. " + SHIFT + code:" .. code, hl.dsp.window.move({ workspace = i }))  -- déplacer la fenêtre vers l'espace i
end

-- espace de travail spécial (scratchpad), exemple
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))            -- afficher/masquer l'espace spécial "magic"
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" })) -- déplacer la fenêtre vers l'espace spécial

-- parcourir les espaces de travail avec mainMod + molette
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))  -- espace de travail suivant
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))  -- espace de travail précédent

-- déplacer/redimensionner les fenêtres avec mainMod + clic gauche/droit et glisser
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })  -- déplacer la fenêtre (clic gauche maintenu)
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })  -- redimensionner la fenêtre (clic droit maintenu)

-- touches multimédia du clavier pour le volume et la luminosité de l'écran
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })  -- volume +5%
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })  -- volume -5%
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })  -- couper le son
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })  -- couper le micro
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })  -- luminosité +5%
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })  -- luminosité -5%

-- nécessite playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })  -- morceau suivant
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })  -- pause / lecture
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })  -- lecture / pause
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })  -- morceau précédent

-- ─── fenêtres et espaces de travail ─────────────────────────────────────

local suppressMaximizeRule = hl.window_rule({
  name  = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name  = "fix-xwayland-drags",
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

-- règle de fenêtre pour hyprland-run
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },
  move  = "20 monitor_h-120",
  float = true,
})

-- règle de fenêtre pour nautilus
hl.window_rule({
  name  = "float-nautilus",
  match = { class = "org.gnome.Nautilus" },
  float = true,
})

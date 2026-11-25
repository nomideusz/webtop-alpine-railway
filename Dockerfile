FROM linuxserver/webtop:alpine-kde-588d6df6-ls154

# MAX_RES capped the Xvfb screen on older X11 bases; this Wayland base ignores it.
# Kept for an X11 fallback. Small plans are handled by railway-gate.sh.
ENV MAX_RES=3840x2160

# ponytail: one custom-init script adds an unauthenticated /healthcheck
# location for Railway's healthcheck prober; everything else is stock.
COPY root/ /
RUN chmod +x /railway-gate.sh /custom-cont-init.d/20-healthcheck /custom-services.d/drop-file-cache /usr/local/bin/drop-file-cache
# Free plan (0.5 GB): serve a "needs 1 GB" page instead of starting the desktop (see railway-gate.sh).
ENTRYPOINT ["/railway-gate.sh"]

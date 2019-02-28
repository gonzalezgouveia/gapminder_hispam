library(tidyverse)
# install.packages(gganimate)
library(gganimate)
# devtools::install_github('rensa/ggflags')
library(ggflags)
# install.packages("gifski")
library(gifski)

# quartz()
anim <- gapminder_hispam %>%
  filter(year >= 1900) %>%
  ggplot(aes(x = log_gdppc, y = lifeExp, country = code)) +
  theme(text = element_text(size=20)) +
  ylim(10,90) +
  scale_x_continuous(breaks = c(2,3,4),
                     labels = c("$400","$4 000","$40 000"),
                     limits = c(2,4.1)) +
  geom_flag(size = 10) +
  transition_states(year, transition_length = 1, state_length = 1) +
  ylab('Años de vida') +
  xlab('Ingreso por persona (USD)') +
  ggtitle('Ahora mostrando año {closest_state}')

animate(anim,
        width = 400, height = 400,
        nframes = 480, fps = 24)

# static version
quartz()
gapminder_hispam %>%
  filter(year == 1900) %>%
  ggplot(aes(x = log_gdppc, y = lifeExp, country = code)) +
  theme(text = element_text(size=20)) +
  geom_flag(size=10) +
  ylim(10,90) +
  xlab('Ingreso por persona (USD)') +
  ylab('Años de vida') +
  scale_x_continuous(breaks = c(2,3,4),
                     labels = c("$400","$4 000","$40 000"),
                     limits = c(2,4.1))

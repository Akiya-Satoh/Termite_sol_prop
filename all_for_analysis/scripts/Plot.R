## dependencies
{
  rm(list = ls())
  source("scripts/sources.R")
  load("data_fmt/Data_tree_genera.Rdata")
  load("data_fmt/Termite_tree.Rdata")
  ##load divided data
  load("data_fmt/Data_tree_genera_ec.Rdata")
  load("data_fmt/Termite_tree_ec.Rdata")
  #assuming all Cubitermitinae are strong-point strategists
  load("data_fmt/Data_tree_genera_cubisp.Rdata")
  #all ambiguous genera excluded
  load("data_fmt/Data_all_exclude.Rdata")
  load("data_fmt/Termite_tree_all_exclude.Rdata")
  
  d <- read.csv("data_raw/Species-level_data.csv") #load species level data
}
#####species-level data#####
{
  sp_mean_values <- d %>%
    rowwise() %>%
    mutate(sp_sol_prop = ifelse(is.na(soldier_prop), mean(c(min, max), na.rm = TRUE), soldier_prop))
  
  df_sp <- sp_mean_values %>%
    group_by(Genus, Species) %>%
    summarise(Mean = mean(sp_sol_prop))
  
  df_sub <- data.frame()
  for (i in 1:length(df_sp$Species)) {
      row_temp <- d[(d$Genus %in% df_sp[i,1])&(d$Species %in% df_sp[i,2]),]
      df_temp <- data.frame(
        Soldier_tac = row_temp[1, 10],
        Family = row_temp[1, 1],
        subfamily = row_temp[1, 3],
        Nest = row_temp[1, 7]
      )
    df_sub <- rbind(df_sub, df_temp)
  }
  df_sp <- cbind(df_sp, df_sub)
  
  df_sp <- df_sp %>%
    mutate(Soldier_tac = factor(Soldier_tac), 
           sol_type = factor(ifelse(Soldier_tac == 0, "Counter-attack", "Strong-point"), 
                             levels = c("Counter-attack", "Strong-point"))) %>%
    arrange(sol_type, Genus) %>%
    mutate(Genus = factor(Genus, levels = unique(Genus)))
}
#####phylogeny data#####
is_tip <- termite.tree$edge[,2] <= length(termite.tree$tip.label)
ordered_tips <- termite.tree$edge[is_tip, 2]
{
For_treeplot <- df_sp[(df_sp$Genus %in% d.all$Genus),]
For_treeplot$Genus <- factor(For_treeplot$Genus, levels = termite.tree$tip.label[ordered_tips])
For_treeplot <- For_treeplot[!is.na(For_treeplot$sol_type),]
}

##### analysis
# soldier type vs soldier ratio
{
  ggplot(data = d.all, 
         aes(x = Soldier_str_string, y = soldier_prop, 
             group =as.factor(Soldier_str_string), 
             fill = as.factor(Soldier_str_string)))+
    geom_boxplot(aes(fill = Soldier_str_string), alpha = .1, width = .25)+
    geom_point(aes(col = Soldier_str_string),
               position = position_jitter(width = 0.05), size = 1)+
    scale_color_viridis(discrete = T, end = .8)+
    scale_fill_viridis(discrete = T, end = .8)+
    theme_classic()+
    theme(aspect.ratio = 1.23, legend.position = "none") + 
    labs(y = "Proportion of soldiers", x = "")
  ggsave("output/SoldierProp_strategy.pdf", width = 3, height = 3)
}

{
  #phylogenetic tree
  ggplot(data = For_treeplot, aes(y = Genus, x=Mean)) +
    scale_color_viridis(discrete = T, end = .8)+
    geom_point(size = .7) +
    theme_classic() +
    theme(axis.text.x = element_text(angle = 0, size=7),
          axis.text.y = element_text(face = "italic", size = 7, vjust = 0.4, hjust=1)) +
    labs(x = "Soldier proportion", y = "") +
    theme(legend.position = "none", aspect.ratio = 3) 
  ggsave("output/Genus_soldierprop.pdf", width = 8, height = 6)
}

#nesting vs soldier type
data_summary <- d.all %>%
  group_by(Forager_string, Soldier_str_string) %>%
  summarise(count = n()) %>%
  group_by(Forager_string) %>%
  mutate(percentage = count / sum(count))
ggplot(data_summary, aes(x = Forager_string, y = percentage, fill = as.factor(Soldier_str_string))) +
  geom_bar(stat = "identity", width = 0.5) +
  scale_fill_viridis(discrete = T, end = .8) + 
  labs(y = "Proportion of defence strategies", x = "") +  
  theme_classic()+
  theme(aspect.ratio = 1.23, legend.position = "none")
ggsave("output/defense_vs_foraging.pdf", width = 3, height = 3)

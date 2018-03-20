---
title: Details on the scripts contained in /fragmentation_of_correspondents/
author: Christoph Kudella
date: 2018-03-03
---
This folder contains scripts that generate the names of Budé's correspondents according to various criteria

| File | Description |
| :------------- | :------------- |
| names_of_corr_with_epp_from_and_to_budé.sql | This script returns the names of correspondents who have both written letters to Budé and received letters from him. NOTE that the total number of these correspondents can be calculated with this query: /corpus_overview/no_corrrespondents_reciproc_epp.sql |
| names_of_corr_with_only_epp_by_budé.sql | This script returns the names of correspondents who received letters from Budé but did not write to him. NOTE that the total number of these correspondents can be calculated with this query: /corpus_overview/no_correspondents_only_epp_by_budé.sql |
| names_of_corr_with_only_epp_to_budé.sql | This script returns the names of correspondents who wrote letters to Budé but did not receive any letters from him. NOTE that the total number of these correspondents can be calculated with this query: /corpus_overview/no_correspondents_only_epp_to_budé.sql |

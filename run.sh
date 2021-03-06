
##########
# 0 is hate
# 1 is non-hate
#########

# Translate the hate data from English to French
# echo "Starting all translation"
# python style_decoder/translate.py -model models/translation/english_french/english_french.pt -src data/hate.train.en -output data/hate.train.fr -replace_unk $true -gpu 0
# python style_decoder/translate.py -model models/translation/english_french/english_french.pt -src data/nohate.train.en -output data/nohate.train.fr -replace_unk $true -gpu 0
# python style_decoder/translate.py -model models/translation/english_french/english_french.pt -src data/hate.dev.en -output data/hate.dev.fr -replace_unk $true -gpu 0
# python style_decoder/translate.py -model models/translation/english_french/english_french.pt -src data/nohate.dev.en -output data/nohate.dev.fr -replace_unk $true -gpu 0
# python style_decoder/translate.py -model models/translation/english_french/english_french.pt -src data/hate.test.en -output data/hate.test.fr -replace_unk $true -gpu 0
# python style_decoder/translate.py -model models/translation/english_french/english_french.pt -src data/nohate.test.en -output data/nohate.test.fr -replace_unk $true -gpu 0
# echo "All translation Finished"

# python style_decoder/translate.py -model models/translation/english_french/english_french.pt -src data/classifier.txt -output data/classifier.txt.fr -replace_unk $true -gpu 0
# python style_decoder/translate.py -model models/translation/english_french/english_french.pt -src data/classifier.dev.txt -output data/classifier.dev.txt.fr -replace_unk $true -gpu 0

# Train the classifier
# echo "Starting classifier Training"
# python classifier/preprocess.py -train_src data/classifier.txt -label0 hate -label1 nohate -valid_src data/classifier.dev.txt -save_data cmodel/hate -src_vocab_size 30000
# python classifier/cnn_train.py -data cmodel/hate.train.pt -save_model cmodel/hate_model -gpus 0
# echo "classifier trained successully"

# Test the classifier accuracy
# echo "Starting classifier Testing"
# python classifier/cnn_translate.py -model cmodel/hate_model_acc_99.32_loss_0.00_e13.pt -src data/hate.test.en -tgt 'hate' -label1 nohate -label0 hate -gpu 0
# python classifier/cnn_translate.py -model cmodel/hate_model_acc_99.32_loss_0.00_e13.pt -src data/nohate.test.en -tgt 'nohate' -label1 nohate -label0 hate -gpu 0
# echo "Classifer testing done"

# Preprocess hate and nohate french source and english target data for the generator
# python style_decoder/preprocess.py -train_src data/nohate.train.fr -train_tgt data/nohate.train.en -valid_src data/nohate.dev.fr -valid_tgt data/nohate.dev.en -save_data generator/nohate_generator -src_vocab models/translation/french_english/french_english_vocab.src.dict -tgt_vocab cmodel/hate.src.dict -seq_len 50

# Train the nohate style generator
# python style_decoder/train_decoder.py -data generator/nohate_generator.train.pt -save_model generator/hate_generator -classifier_model cmodel/hate_model_acc_99.32_loss_0.00_e13.pt -encoder_model models/translation/french_english/french_english.pt -tgt_label 1 -gpus 0

# Translate the hate test set using the best nohate generator
# python style_decoder/translate_enc_dec.py -encoder_model models/translation/french_english/french_english.pt -decoder_model generator/hate_generator_acc_48.78_ppl_3.93_e13.pt -src data/hate.test.fr -output data/hate_to_nohate.txt -replace_unk $true -gpu 0

# Test the accuracy of converted sentences
# python classifier/cnn_translate.py -model cmodel/hate_model_acc_99.32_loss_0.00_e13.pt -src data/hate_to_nohate.txt -tgt 'nohate' -label1 nohate -label0 hate -gpu 0
# python classifier/cnn_translate.py -model cmodel/hate_model_acc_99.32_loss_0.00_e13.pt -src data/hate_to_nohate_proc.txt -tgt 'nohate' -label1 nohate -label0 hate -gpu 0

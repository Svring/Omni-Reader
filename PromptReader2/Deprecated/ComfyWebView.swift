//
//  WebView.swift
//  PromptReader2
//
//  Created by Monophotic on 2024/4/2.
//

import SwiftUI
import WebKit

struct ComfyWebView: View {
    let workflowData: String

    var body: some View {
//        WebView(url: Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "dist")!, workflowData: workflowData)

        WebView(url: Bundle.main.url(forResource: "Comfy", withExtension: "html")!, workflowData: workflowData)
    }
}

struct WebView: NSViewRepresentable {
    let url: URL
    let workflowData: String

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        
        let script = """
        
        """

        webView.evaluateJavaScript(script, completionHandler: { _, error in
            if let error = error {
                print("Error calling JavaScript: \(error)")
            }
        })
        
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
//        let script = """
//        let workflowData = '{"last_node_id": 5, "last_link_id": 6, "nodes": [{"id": 4, "type": "SaveImage", "pos": [1347, 244], "size": {"0": 315, "1": 58}, "flags": {"collapsed": true}, "order": 3, "mode": 0, "inputs": [{"name": "images", "type": "IMAGE", "link": 4}], "properties": {}, "widgets_values": ["ComfyUI"]}, {"id": 2, "type": "KSampler SDXL (Eff.)", "pos": [985, 239], "size": {"0": 325, "1": 546}, "flags": {}, "order": 2, "mode": 0, "inputs": [{"name": "sdxl_tuple", "type": "SDXL_TUPLE", "link": 1}, {"name": "latent_image", "type": "LATENT", "link": 2}, {"name": "optional_vae", "type": "VAE", "link": 3}, {"name": "script", "type": "SCRIPT", "link": null}], "outputs": [{"name": "SDXL_TUPLE", "type": "SDXL_TUPLE", "links": null, "shape": 3}, {"name": "LATENT", "type": "LATENT", "links": null, "shape": 3}, {"name": "VAE", "type": "VAE", "links": null, "shape": 3}, {"name": "IMAGE", "type": "IMAGE", "links": [4], "shape": 3, "slot_index": 3}], "properties": {"Node name for S&R": "KSampler SDXL (Eff.)"}, "widgets_values": [-1, null, 28, 7, "euler_ancestral", "normal", 0, -1, "auto", "true"], "color": "#332222", "bgcolor": "#553333", "shape": 1}, {"id": 5, "type": "LoRA Stacker", "pos": [165, 244], "size": {"0": 315, "1": 298}, "flags": {}, "order": 0, "mode": 0, "inputs": [{"name": "lora_stack", "type": "LORA_STACK", "link": null}], "outputs": [{"name": "LORA_STACK", "type": "LORA_STACK", "links": [6], "shape": 3, "slot_index": 0}], "properties": {"Node name for S&R": "LoRA Stacker"}, "widgets_values": ["advanced", 3, "None", 1, 1.2, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1, "None", 1, 1, 1], "color": "#222233", "bgcolor": "#333355", "shape": 1}, {"id": 1, "type": "Eff. Loader SDXL", "pos": [549, 240], "size": {"0": 349.94561767578125, "1": 685.647216796875}, "flags": {}, "order": 1, "mode": 0, "inputs": [{"name": "lora_stack", "type": "LORA_STACK", "link": 6}, {"name": "cnet_stack", "type": "CONTROL_NET_STACK", "link": null, "slot_index": 1}], "outputs": [{"name": "SDXL_TUPLE", "type": "SDXL_TUPLE", "links": [1], "shape": 3, "slot_index": 0}, {"name": "LATENT", "type": "LATENT", "links": [2], "shape": 3, "slot_index": 1}, {"name": "VAE", "type": "VAE", "links": [3], "shape": 3, "slot_index": 2}, {"name": "DEPENDENCIES", "type": "DEPENDENCIES", "links": null, "shape": 3}], "properties": {"Node name for S&R": "Eff. Loader SDXL"}, "widgets_values": ["animagine-xl-31.safetensors", -2, "None", -2, 6, 2, "Diffusion PyTorch Model.safetensors", "1girl, solo, petite, bishoujo, expressionless, shy, black hair, long hair, emerald eyes, green hat, cat hood, hood up, white inner shirt, black-green coat, medium breasts, black miniskirt, black thighhighs, black leather shoes, standing, looking at viewer, front view, straight on, (masterpiece), (best quality), (ultra-detailed), very aesthetic, illustration, perfect composition, cinematic angle, moist skin, intricate details, newest, artist:alp, {dino (dinoartforame), ciloranko}, [[[[kuroduki (pieat)]]]], [[ask (askzy)]], maeda_hiroyuki,", "lowres, bad anatomy, bad hands, text, error, missing fingers, extra digit, fewer digits, cropped, worst quality, low quality, normal quality, jpeg artifacts, signature, watermark, username, blurry, artist name, extra arms, unaestheticXL_Alb2, off shoulders", "none", "comfy", 1024, 1536, 4], "color": "#332233", "bgcolor": "#553355", "shape": 1}], "links": [[1, 1, 0, 2, 0, "SDXL_TUPLE"], [2, 1, 1, 2, 1, "LATENT"], [3, 1, 2, 2, 2, "VAE"], [4, 2, 3, 4, 0, "IMAGE"], [6, 5, 0, 1, 0, "LORA_STACK"]], "groups": [], "config": {}, "extra": {}, "version": 0.4, "widget_idx_map": {"2": {"noise_seed": 0, "sampler_name": 4, "scheduler": 5}}}';
//
//        var graph = new LGraph();
//
//        var canvas = new LGraphCanvas("#mycanvas", graph);
//
//        const workflow = JSON.parse(workflowData);
//
//        const prop = {};
//        const types = Array.from(
//            new Set(
//              workflow.nodes.map((node) => {
//                prop[node.type] = node;
//                return node.type;
//              })
//            ).values()
//          );
//
//        types.forEach((type) => {
//            function MyNode() {}
//
//            //name to show
//            MyNode.title = type;
//            LiteGraph.registerNodeType(type, MyNode);
//            });
//
//        graph.configure(workflow);
//
//        workflow.nodes.map((item) => {
//            const node = graph.getNodeById(item.id);
//            if (item.widgets_values) {
//              item.widgets_values.forEach((val) => {
//                node.addWidget("text", "", val);
//              });
//            }
//          });
//
//        graph.start()
//        """
//
//        nsView.evaluateJavaScript(script, completionHandler: { _, error in
//            if let error = error {
//                print("Error calling JavaScript: \(error)")
//            }
//        })
    }
}

#Preview {
    ComfyWebView(workflowData: "123")
}

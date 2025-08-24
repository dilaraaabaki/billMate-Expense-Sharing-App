//
//  PrivacyPolicy.swift
//  billMate
//
//  Created by Dilara Baki on 23.08.2025.
//

import SwiftUI

struct PrivacyPolicy: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Privacy Policy")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("Last updated: \(getCurrentDate())")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("We respect your privacy and are committed to protecting your personal data. This privacy policy explains how we collect, use, and safeguard your information when you use our app.")
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    Divider()
                        .padding(.horizontal, 20)
                    
                   
                    LazyVStack(alignment: .leading, spacing: 32) {
                        PolicySection(
                            title: "Information We Collect",
                            content: """
                            We may collect the following types of information:
                            
                            • Personal Information: Name, email address, and contact details when you create an account
                            • Usage Data: Information about how you use our app, including features accessed and time spent
                            • Device Information: Device type, operating system, and unique device identifiers
                            • Location Data: With your permission, we may collect location information to provide location-based services
                            """
                        )
                        
                        PolicySection(
                            title: "How We Use Your Information",
                            content: """
                            We use the collected information for:
                            
                            • Providing and maintaining our services
                            • Personalizing your app experience
                            • Communicating with you about updates and features
                            • Improving our app functionality and user experience
                            • Ensuring security and preventing fraud
                            • Complying with legal obligations
                            """
                        )
                        
                        PolicySection(
                            title: "Data Sharing and Disclosure",
                            content: """
                            We do not sell, trade, or rent your personal information to third parties. We may share your information only in the following circumstances:
                            
                            • With your explicit consent
                            • To comply with legal requirements or court orders
                            • To protect our rights, property, or safety
                            • With trusted service providers who assist in app operations
                            • In connection with a business transfer or merger
                            """
                        )
                        
                        PolicySection(
                            title: "Data Security",
                            content: """
                            We implement appropriate security measures to protect your personal information:
                            
                            • Encryption of data in transit and at rest
                            • Regular security assessments and updates
                            • Limited access to personal data on a need-to-know basis
                            • Secure servers and data centers
                            • Industry-standard security protocols
                            """
                        )
                        
                        PolicySection(
                            title: "Your Rights and Choices",
                            content: """
                            You have the following rights regarding your personal data:
                            
                            • Access: Request access to your personal information
                            • Correction: Update or correct inaccurate information
                            • Deletion: Request deletion of your personal data
                            • Portability: Request a copy of your data in a portable format
                            • Opt-out: Unsubscribe from marketing communications
                            • Withdraw consent: Revoke previously given consent
                            """
                        )
                        
                        PolicySection(
                            title: "Cookies and Tracking",
                            content: """
                            Our app may use cookies and similar tracking technologies to:
                            
                            • Remember your preferences and settings
                            • Analyze app usage and performance
                            • Provide personalized content and recommendations
                            • Improve overall user experience
                            
                            You can manage cookie preferences through your device settings.
                            """
                        )
                        
                        PolicySection(
                            title: "Children's Privacy",
                            content: """
                            Our app is not intended for children under 13 years of age. We do not knowingly collect personal information from children under 13. If you believe we have collected information from a child under 13, please contact us immediately.
                            """
                        )
                        
                        PolicySection(
                            title: "Changes to This Policy",
                            content: """
                            We may update this privacy policy from time to time. We will notify you of any material changes by:
                            
                            • Posting the updated policy in the app
                            • Sending you an email notification
                            • Displaying a prominent notice in the app
                            
                            Your continued use of the app after changes constitutes acceptance of the updated policy.
                            """
                        )
                        
                        PolicySection(
                            title: "Contact Information",
                            content: """
                            If you have questions, concerns, or requests regarding this privacy policy or your personal data, please contact us:
                            
                            Email: privacy@bilmate.com
                            
                            We will respond to your inquiry within 30 days.
                            """
                        )
                    }
                    .padding(.horizontal, 20)
                    
                    VStack(spacing: 16) {
                        Divider()
                        
                        Text("Thank you for trusting us with your information. We are committed to maintaining the highest standards of privacy and data protection.")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .lineSpacing(2)
                        
                        Text("© 2025 billMate. All rights reserved.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .foregroundColor(.accentColor)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: { sharePolicy() }) {
                            Label("Share Policy", systemImage: "square.and.arrow.up")
                        }
                        
                        Button(action: { printPolicy() }) {
                            Label("Print", systemImage: "printer")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(.accentColor)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: Date())
    }
    
    private func sharePolicy() {
        print("Share policy tapped")
    }
    
    private func printPolicy() {
        print("Print policy tapped")
    }
}

struct PolicySection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(content)
                .font(.body)
                .foregroundColor(.primary)
                .lineSpacing(6)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct PrivacyPolicy_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicy()
            .preferredColorScheme(.light)
    }
}
